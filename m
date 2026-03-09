Return-Path: <linux-pm+bounces-43960-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGG4IujxrmnZKgIAu9opvQ
	(envelope-from <linux-pm+bounces-43960-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 09 Mar 2026 17:14:32 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08BF223C8DA
	for <lists+linux-pm@lfdr.de>; Mon, 09 Mar 2026 17:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE15D306B4DD
	for <lists+linux-pm@lfdr.de>; Mon,  9 Mar 2026 16:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBA93BFE21;
	Mon,  9 Mar 2026 16:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="russ3RdD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6346C3B8BD2
	for <linux-pm@vger.kernel.org>; Mon,  9 Mar 2026 16:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773072523; cv=pass; b=o4Up2Q/SCtM0248P2ru0ZQz986Tmf61i7BmeSPH/de/kqrBiSHHrwhuS9cMubpdaOIbSTA7C7sMYtEnt90JcTaoftr1zOxjFO5MnB5UGfItTCq2JmEuewl9s4EIkSrHt1OBWCOWHDex3qL74jLER+op69c2jirQRIdoRHKc1GYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773072523; c=relaxed/simple;
	bh=Yot0xbyHJsj7QAQS3vNY/dGwb6uIyCI/vA1cs4XLkGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZGHl2aHN4xHL9TDRanjrFo613WaU+l7E8WD4Knq+GKJzcoC1EIVb6mO+ketIR9Yx+vFa/0UgV2HsTwdhNlhBcX+5QM5UaktHz0b1VELdXXigEGTx9F7DPKL9+W8MCYWr4GHTTwe+R2pWlMV23qBPkj9Co9S5CaBnsnGmD9JpCLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=russ3RdD; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-50906a98ffeso953411cf.0
        for <linux-pm@vger.kernel.org>; Mon, 09 Mar 2026 09:08:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773072521; cv=none;
        d=google.com; s=arc-20240605;
        b=b1XUNRhDdW4zZrIXql+7Fa1+u0F2T3qGQRDzXGfuzlp7alyandsYQD6I8vynz2r3F9
         fRQAYVlB2F1AbGnxruN28Qq6d3mjeUawjWrmzBc69kEPw0gUs/y4WwhIWOTwInu1Pewa
         OP5bHzKWRZmCeSsUWmsnZb3G1PloiShddUIhXmJpftLKrbCCvp+cXQnaFitMCWE5LH+/
         SQmz7iFfxVd3FJA0rO4ZTn7aTlXulVmt0EMUy4+1r9iH0njCuUMDq/ZwF+h6fJ37nOr8
         DWpW1XeRBPp35U6SLjS8bFU8KpD3/6f6QzTAK4pQl/tv3XoR+Eit0g9tm6mNPBzVwwBW
         alww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dJZjcWqdTMUm135cItrOwLK6G6oxwB/Ydqo2W3I/EPo=;
        fh=4E5Qud9CgVNuDe4a9qar+lvZfD5JXgCK84lPzMltXGs=;
        b=DeSKSNdaCQwmXQ/ay2CXiC3PmefRCDVaVb7FivEJX/LPyV0lVgCcS17ZiExwyr+99m
         qxhc7hejGSOefHLoiI3JZuiFW+xd4ppeLOPnNRbh0Q2Rs1RfKSbvB1Ux1Zgo2nCVEuG8
         xEgyZzTaSVHDBJTCdzj+liNAKVbXZL+UlnGMqMK822rmu2SMOZeKty+D7a0moapuyV2b
         okbAxWAwVisW0AT55JQT6gyPiIdQ2bSK6CSMnyA14gg7jMP0G6FF+qAhFo/7869drZ1N
         zKZk0N5yvWiw8gCmP1Q4bPg0fumI+OqXZqcQ+BgkxMV069DkmKwVmHkI/uGNtaX6hC8v
         PjLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773072521; x=1773677321; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dJZjcWqdTMUm135cItrOwLK6G6oxwB/Ydqo2W3I/EPo=;
        b=russ3RdDmRqNGkjlVdjkxLsK1aUe3+2pNSACBA4jzXTfTs/pd74w4jjU901WJ3jJct
         phiGfSUPgn9tfnI/xR6wsBGnSH/EsopoaFH8EF/FZrYAFGbnRYyzDJukCEPKkmPyC921
         i683+bPX4lemfxBAp941ndG7IbqR+jD/+SbQcaGSADpf4QVUMVUIQV0LXOeufxKkxx6H
         21GJRaOkyrBQ+0or7Xn/DWfTR2PNsV49F6r/wIkxl3c6QhlYWoia56GvRNANlU+G16ex
         Zw+uSwXet/knypz+fiXGfyTTpA4HFjgRfyPkAr8tWQXhwURbL+LS2msFKiAZVZ6cUWwn
         mqJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773072521; x=1773677321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dJZjcWqdTMUm135cItrOwLK6G6oxwB/Ydqo2W3I/EPo=;
        b=d1niLqpqGjEjVvQQZCE87eXVCYqvdEi1IsAa47SXz7hk7vt9uK5+I6klnRewq+hduJ
         CIP36h1RzUYKvR1AD2ilOwu/bp7ALV3sOLBIZu6p9xA8BlrTu8NvXr7Sc+2vvrrIwtQ/
         yTD8vC5g5JMSMFcOj58rVJd3qecfiQTUwucQ7yb6FpKdvB2nN723yD0/0Fdb1QbpvIlZ
         2MIBfweV2pkZCK4NCetjmwgq2b7vHYozWO9KylYgaDn7dZiw7QGq9+RTp7n4fEYG1bck
         8yytnaAAuHIH+iXmtOBOYlCtZgqAwyN9HvVRiDIBD2u7WcpO65WD1cL8ffg5jE9c+hAD
         /wbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWeeSLKB9TcyNHmbmAHjfuC9ibtSrCEYTDcO6on9Qw/VmMd73jureVsqmPuxAV9ahSnJiDgIE9zg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwal+ShzxeXBESUXbjGWQLUCB32xRE91NpolLjpRymRnjygIUi
	6SPujGFBx8T80WuFcCb5GEDTkiGQ8JqjwgEpWnfnDEkgPVLUdSeOnzuEZKvKvy2mqR4yap6Pnuw
	KHoT7/KDjYm5t8pZLv1S1XZGSpCEGhWoQgIlvBeKC
X-Gm-Gg: ATEYQzxjQLXN54t5xJRE+2dbZv27VUY/DLCDL8MSwAP/RQNe6gcdyxSnYw5TC6ZT7QQ
	hwhOEl+s4ol7apctPozhy5exKyoWNkMntDd+ooILFAiMrYdTMwy+0qXq4YJRUhAQ6eaJWOKxi54
	Ry2ZvX9xNWIRt62b/eNggrHziA2oxFBIK0H3oLkWxNE021BF8+Zz5BsjC5b2ADNnV56j3kbxkjz
	/RJdRwdJ8JY0k7hjQopTUzTiWPklyXJwooXsGU/MyPUHaGsRr7nUWEkUs8oe/l5Gv/xnaMykyH1
	Zp8P45mQbFhVWiBt8NNrnDDGEECZBeRBnIP3yssxsjdLgxyBIYkNB6qG6eqJ7iIjzDBnaDSsXZ7
	zFMHx3A82dKW23woECwaHtDI8
X-Received: by 2002:a05:622a:251:b0:4f3:54eb:f26e with SMTP id
 d75a77b69052e-50902abee95mr23991441cf.1.1773072520504; Mon, 09 Mar 2026
 09:08:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309001250.192841-1-berto@igalia.com> <aa6uYoVKegcac2Kq@igalia.com>
 <CADyq12z_mhjY9S1_jawX8UuviyYf-ozXn6Q6yB4dHxopD7JmTg@mail.gmail.com> <aa7uBMrSII5l-Ofl@igalia.com>
In-Reply-To: <aa7uBMrSII5l-Ofl@igalia.com>
From: Brian Geffon <bgeffon@google.com>
Date: Mon, 9 Mar 2026 12:08:04 -0400
X-Gm-Features: AaiRm52ASV7dzyShi1mBohYTHILYRm6S75s307c8okWIrQo3eHDFWTbzZFQ-n2U
Message-ID: <CADyq12zULXjnvikfXn1zPUNzqZGPSbx4LcR56BUOzJD6O8vPDA@mail.gmail.com>
Subject: Re: [PATCH] PM: hibernate: Drain trailing zero pages on userspace restore
To: Alberto Garcia <berto@igalia.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 08BF223C8DA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43960-lists,linux-pm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bgeffon@google.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.963];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,igalia.com:email]
X-Rspamd-Action: no action

On Mon, Mar 9, 2026 at 11:57=E2=80=AFAM Alberto Garcia <berto@igalia.com> w=
rote:
>
> On Mon, Mar 09, 2026 at 11:01:15AM -0400, Brian Geffon wrote:
> > > An alternative solution would be to do it at the beginning of
> > > snapshot_write_finalize() if handle->cur > nr_meta_pages + 1.
> >
> > I think this makes sense, but if snapshot_write_next() returns
> > PAGE_SIZE then we need to indicate some error (eg. -ENODATA) in that
> > the kernel was still expecting another copy page.
>
> This would fail anyway in snapshot_image_loaded() because of this
> condition:
>
>    handle->cur <=3D nr_meta_pages + nr_copy_pages + nr_zero_pages

A subtle bug exists where if you had exactly 1 page remaining (which
was to be copied) handle->cur would have been incremented in
snapshot_write_next(), however, no data would have been copied into
that page.

>
> But I think it make sense to return an error directly from
> snapshot_write_finalize() as you suggest, I can use -ENODATA.

Yes, I think the safest option is if you call
snapshot_write_finalize() and snapshot_write_next() returns a positive
value you return -ENODATA.

>
> > Also it appears that the kernel restore path and the userspace restore
> > path return two different error codes for !snapshot_image_loaded(),
> > the former does -ENODATA and the latter -EPERM.
>
> Yes, -EPERM is the one that I hit in my tests.
>
> Does this need to be corrected?

Yes, I think we should change that code to check if
!snapshot_image_loaded() and explicitly return -ENODATA rather than
-EPERM which is meant for cases where the operation is neither
write-only nor ready. This new explicit check should happen after
that.

>
> Berto


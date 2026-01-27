Return-Path: <linux-pm+bounces-41572-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sF9nBkr3eGnYuAEAu9opvQ
	(envelope-from <linux-pm+bounces-41572-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 18:35:06 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E3598802
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 18:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 65659300139C
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 17:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D860030BB95;
	Tue, 27 Jan 2026 17:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A6zJ8FSS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rlS+j0gd"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC2B30B535
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 17:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769535298; cv=pass; b=T4xLuRR7ym4dial9M2agjGoa3OG9RlpJdErZy2k49lyKF6DPMVP1f74CKa8kOJtZyNNXaAOwE8BznL/EYlERj8AbbF6qxBXY8BHk4KfgLMBMddmwgyqS7iK7zTqOKuiQ6UPFVcgNWrkr7jNUdyR3KJf+5b7w17JHaPuyYBnYsTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769535298; c=relaxed/simple;
	bh=Ut++MG2NVDhX9ym8sf6DMoDcdX8Jq1RCrEj4s6KljZ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xk+efxET8hVQDMRhzpxok8ZgE9l+zH+N2vZFoKTSknsUUbUFZXByLaG9suYnEcX6XKUYn0zmcj/2QKbZ19cyYPCECY7WK/sowjbI9A0NFPLqu6kh8IVqT1pHrzYxBSSGtX/wugspUA9d15Vg6ZbbjiPvHxP0212fuheayTXhyss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A6zJ8FSS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rlS+j0gd; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769535296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2PEADRREE8diWjtqyEmOKApUqCQa0lmemd4M3FtH15k=;
	b=A6zJ8FSSxluY0kXmwQXXKBzshLjiMCUccOQ8X1LSSMWIOCGYKIqG1HNaPuwTn1n2wa80qP
	hGaPG4hpTdQC8wy7doWlt2mgLUAL97G2TyGXJ4mQXIS2fLmUeL3kUNG30BysM7VhifMwPE
	hihk9k8yerYJzTFPwQ2kP2x0iPe5Eh4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-LhQSK8hANaK6bVikcI-ueg-1; Tue, 27 Jan 2026 12:34:54 -0500
X-MC-Unique: LhQSK8hANaK6bVikcI-ueg-1
X-Mimecast-MFC-AGG-ID: LhQSK8hANaK6bVikcI-ueg_1769535294
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b88649b11d2so441424966b.3
        for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 09:34:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769535294; cv=none;
        d=google.com; s=arc-20240605;
        b=Z+RSOSyxoJtYzQyFj3EH8xTY7j7C1VQ6DAeij5NNEzYG0sMtXiZC4IAm5ntiC9zsps
         ZnpNpxngQ45v2XkPTYphXAvx6ouCTFfs1AvgnR4ChcJRX9R1mprBt2peDbd47gw84icr
         GygVcmL56awIhc2jU6DEpbOECfA71rYVe+tSjsBysbwLMqY7Nuerk8N5lbmxMdPcfMNw
         iaZXLYuhnTHh/rT/MZZM///7XKXYgT1saLnhsKDkojMbBG6KceLjzKaEikfp7UOcex+k
         7OTB0gysJBLpVLHtpDKMmyYZ5cywL9dWbkNZ3P73WWTuVhiPCdsh+j9awbSOxhMVx69E
         YWrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2PEADRREE8diWjtqyEmOKApUqCQa0lmemd4M3FtH15k=;
        fh=f4ouyS49qPvfceLBSvspBDH8/pja7jtV3f4aoHxo35E=;
        b=ieMxkb4wltiwIZ3iV0d9lLYYxhhK6wz/Ux6003TzQ0UL8+69Oqdl9pCZz2buwspFVC
         DWwqsHRX0ohZNufLa/GNGzlbs4KXloFCuji8mFxcdzMmDNS7MYCH5ixXi/++FgEIA+/Q
         R8VJT+B++ATEsQFX5/5EfCwlU7GwNvVLMWdINV3+H7yB9FJmT1P3/XY/OOLKXfkBTINF
         xormNSYoZgW0g+FjGIRReiDNp1rDoapWgEhTUXhHAsj9wnFi9nw0njICwDQhuzN7QUzd
         3ThbUastN7rgnFEpBbaEqj/nJN3rzVZQvjTiM3eQcRwhvrV792SBE5CM8L0kpyUWTEa4
         maEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769535294; x=1770140094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2PEADRREE8diWjtqyEmOKApUqCQa0lmemd4M3FtH15k=;
        b=rlS+j0gd/LowuUMbftzH/BDdHYXYjP0lxocGDrURD9qAISSVenAMJMeYuM6gYftKPt
         d0DohySImn3Jv1QxJeUGRrBjzOTvhtR0xi35sAKOogIPt8jdSs/7dtzNW7BQk8EiMpsv
         M5zpRhtIfSHIYRRzDd65xtg0kmRbQnuv1wwvmZjYh5yjHS/H8Cua60PdU3fOTlRkfHQj
         FY/L1m7oe/qEtWyXYJnFQUJQ4OE87D+d+5z7vVMUeKndgblvDmnRoFCWaxWxSyugBErR
         vuugo0fwXRXjpeLbn7WR22p7YVdAd4a+N1nFC6cLAUeZ2bwt6RW/B7nXi3TY4IiyZJSD
         cYIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769535294; x=1770140094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2PEADRREE8diWjtqyEmOKApUqCQa0lmemd4M3FtH15k=;
        b=Q9Q7m4sbrJquuWwCEzcfSVeL30wgf46JPtAIjIDaSZ/weeLQmdELlWJMYW0j58GJmQ
         EkyDXrA4e8WZEHDrgLoDhSfqhHixsIC0K4vnzc6uD+vfVXhDWwVlF9ve0RGrLHSAJCuL
         l+wFr7rMTy+FpbszRXxxMqIm+vF3+9tBdkrwCJ0PD8V3kuU8sVC9e1Rv1E5oOKu8vVi7
         FAZ58CGWjBY7WOYrYsR1HF8EE2E5010BMkrn0Taudl3dLnUKsjuKw+OXOJeXPgoeX0Pk
         l0Qm7IakF9pOuqi9HzdKf7/MErgckaKMThGbVdTzvjx+2aK5lHpiFtGRy2OjoUk81AvB
         zuOw==
X-Gm-Message-State: AOJu0YwiGN7o6lUINXKLYspbJJNDFO7+vyF3sdmxbSTfZmZ9Raa+Oim3
	WMTag+/FDeDXt0Ee9b58grxf86O+9nSNewBdy1+WV8TZOKjNv1F6N3QUAq1HozKClK5Ip2I9Koq
	nM97NDQyhIso7robwNG+GoSUanRy32LboKtO7lrx0b3Xgddf8NQVS7tWDpMKVkAePyHf1zlMw+q
	KBC+hbWh5E2OiZukohro9fuYZ7p8WyTAD1M0w=
X-Gm-Gg: AZuq6aJ6dLxd8GG0KtFlwsZ6CZ/Mb5CT/oaJFZF5s611hvtYaAEUDm0EsBwD8aoETSU
	Er8N0RdiNMwJjsihaaeiYR/2vU1S6G8LxsAyFKU5lmPuYXxGeta+PAejuZBGnTdw3FS9sIGiHio
	yv451Bl4QOyNtDIAKDUFwBEouYhpVgyLcEwmfyrR+i34Ojilk7llN1VhwMmgu/ewNFvNZfsSubV
	dAsHhiBweX4P99KaXYNjSCJnnAq
X-Received: by 2002:a17:907:a49:b0:b87:3168:2cb9 with SMTP id a640c23a62f3a-b8dab32ff52mr207299166b.32.1769535293658;
        Tue, 27 Jan 2026 09:34:53 -0800 (PST)
X-Received: by 2002:a17:907:a49:b0:b87:3168:2cb9 with SMTP id
 a640c23a62f3a-b8dab32ff52mr207298066b.32.1769535293177; Tue, 27 Jan 2026
 09:34:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6233709.lOV4Wx5bFT@rafael.j.wysocki>
In-Reply-To: <6233709.lOV4Wx5bFT@rafael.j.wysocki>
From: Malaya Kumar Rout <mrout@redhat.com>
Date: Tue, 27 Jan 2026 23:04:42 +0530
X-Gm-Features: AZwV_QghNwMQJwq8DbgIIRDRicVqGUI515GL2DW77jBwWqOH7g0MA04NQq-MQbk
Message-ID: <CADD9qejrh=hEFrvQNvGcHW3SJFgOKM8daQ9eRasDwiJi9J2pNQ@mail.gmail.com>
Subject: Re: [PATCH v1] PM: hibernate: Drop NULL pointer checks before acomp_request_free()
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-41572-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrout@redhat.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-1.000];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 24E3598802
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 1:34=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Since acomp_request_free() checks its argument against NULL, the NULL
> pointer checks before calling it added by commit ("7966cf0ebe32 PM:
> hibernate: Fix crash when freeing invalid crypto compressor") are
> redundant, so drop them.
>
> No intentional functional impact.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  kernel/power/swap.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> --- a/kernel/power/swap.c
> +++ b/kernel/power/swap.c
> @@ -902,8 +902,8 @@ out_clean:
>                 for (thr =3D 0; thr < nr_threads; thr++) {
>                         if (data[thr].thr)
>                                 kthread_stop(data[thr].thr);
> -                       if (data[thr].cr)
> -                               acomp_request_free(data[thr].cr);
> +
> +                       acomp_request_free(data[thr].cr);
>
>                         if (!IS_ERR_OR_NULL(data[thr].cc))
>                                 crypto_free_acomp(data[thr].cc);
> @@ -1502,8 +1502,8 @@ out_clean:
>                 for (thr =3D 0; thr < nr_threads; thr++) {
>                         if (data[thr].thr)
>                                 kthread_stop(data[thr].thr);
> -                       if (data[thr].cr)
> -                               acomp_request_free(data[thr].cr);
> +
> +                       acomp_request_free(data[thr].cr);
>
>                         if (!IS_ERR_OR_NULL(data[thr].cc))
>                                 crypto_free_acomp(data[thr].cc);
>
>
>
Thanks, this makes sense to me. Dropping the redundant NULL checks
looks correct.



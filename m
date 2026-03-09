Return-Path: <linux-pm+bounces-43964-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2CCTMiQHr2knLwIAu9opvQ
	(envelope-from <linux-pm+bounces-43964-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 09 Mar 2026 18:45:08 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 490D123DCCF
	for <lists+linux-pm@lfdr.de>; Mon, 09 Mar 2026 18:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 61FAC3009993
	for <lists+linux-pm@lfdr.de>; Mon,  9 Mar 2026 17:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC5C1F181F;
	Mon,  9 Mar 2026 17:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g/y/FxAJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBAE3AA1A2
	for <linux-pm@vger.kernel.org>; Mon,  9 Mar 2026 17:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773078300; cv=pass; b=kH7I26KoOnYc2u2R4gZ9zbYPzVJLsABLAGi0mN+z2/jyUrt/SYgezP9t8b3Y2Ydklsld7gYiPkA0qkk4XRH2vryyQhtz/9XrCplJ5PyQNNv4UeBPjtAWW7CWbG3oww7Cy3ZikVGoZa8lKK9bevOhMa5rrVUJg7jwMwIP2Tnplak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773078300; c=relaxed/simple;
	bh=oN48eUPZRpR5n8V2znA/4aeEKQrIk8ok6FBOXV/L8ag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P4YDnaXanKj7ib4yJfAVjBYPdNnDCANc1q4TXvkZHeY7QPXCjtsbDqD92HfXoTFdevY9JYE3ekx3UrImmrWD+aAbLY5BTTcTuaqmgV6v0o7m1XUacnljcgDzNy9Nb8gR/39w9640Dh6sfcpicxgDgtnU/uj2Bq5AUfPPPNiP2S0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g/y/FxAJ; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-509062d829dso63471cf.1
        for <linux-pm@vger.kernel.org>; Mon, 09 Mar 2026 10:44:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773078298; cv=none;
        d=google.com; s=arc-20240605;
        b=GWkIEpYny/70b2K2kgnTr23051ERKER71xxoCkC9YDomvMQbo2xbY35Pv1shPRknuj
         2oLKIqIJRg09iETk3zHvAHgQMGeFB6+E+SSdNFiIHFYISvFFjvHIvEOEe6Fc3y3BF/jx
         CJ8psk0P7GBFhswG3rh87p6Pnh27OmccpJo+Fet1eUMY5r/PpLFUpwJmZU3vOexqfnyn
         K/L0yhHx4dgN7eqniTTtJPDyqpEl9arEFteFSzDeg2gOXzTkFdCCIIqJJu97+TfWjEJh
         fUQ4T4n50bwu7cyEM09XWkcVNc/RxDMYfbqNMr9ntUv6ZpYwlm32GFt4jiC5ZiY6qC1O
         AT0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BhkTSNVf6shcn1pf+0ogaGz34muRPcS8qEJuJO0nQd4=;
        fh=keER9RuSXie2tp5Vvo4UdbrVAetAHIp8SDLceMAfzNM=;
        b=FMoUeml2r/L2VXf1tqToKllKyqqiz4wn0MsucS1XxHQmbCiP7XpO5UR7p6aZYY3Ezq
         mD63jPWiLXFt6mgYKxzO/wMuXjTzOTXE9hXDlChu99In8YcYGeteaXp08yXybCmSS+6C
         iH+UvB86DqRxoMXhiFIN8sPOtK80EvjxR/WTZ/xOyeKmaaMW5wJ5qWVaqaNdEX3NKfKS
         oFwOtSKPFuvSdo1t2YS6RUM2njdK7abjbrBRrYUh+wcsCR3EjgvGBx/c74zxaWvAz9dH
         6stSIh9TgpIY2HLMiNsj5VG5XQl7kQkNVRv6/epnMvgAIEoXwQJAZx8J9Z1qBCtbyss9
         6M6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773078298; x=1773683098; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BhkTSNVf6shcn1pf+0ogaGz34muRPcS8qEJuJO0nQd4=;
        b=g/y/FxAJ4Umbti6M03hBc/Yl97Wy+pfxG7UllWy+qrkszJqOCx6KdrfROB6FGiv+iX
         DwAjUFSRglz32HhpgqCdXFWsqZJyzTnFTgk75cuOAt/ECavSHWn3RmGcX/kHGTZwOJXq
         jPOAhmacIJ7/taedhRHiG+j6HTsWGoOlTkxUlyD698rt4QVEdEFCrrT6g1dAvHG1Nhb2
         xZbSliEDDxWusGlOxScuIMvI+6s0Z/94cpntdysHOsfGBdpzhsdmnYu2za0aM1CKxr/D
         DyxgcpfyDKFBzcbpUWunbIhqUVzyyo/Ns8ANehFpqRnGLgODCfrk3vj5GujQ9eN1SZ/a
         lm/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773078298; x=1773683098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BhkTSNVf6shcn1pf+0ogaGz34muRPcS8qEJuJO0nQd4=;
        b=wHUK0BwyCqFzlaEvyjRq7FxFN8afco9MmeFdyjgQrGr/0HAwS3SKXW1kha/wotnXTP
         mH0d2N7tyeeVzHt4gOfgKf9lTm9n0NWECG+q9MviLpz/0NmtB6XycQfdlbGC6qfN+WkJ
         dEpt+c+BHa7+MOkJvQAiVm0dEzbKDArACA9tDrS5fF2G794rwbCnqFV+PlbKxFTEc+xx
         OJn+ZI4+gb2EJfWrDUUrAP/WH0o30RtXiA9pbTxQsPrnZF18vPpsoOd04D5XVNyc+hwA
         UN97uG6jUg5DzFkKAuz9xQidGqe1JWKBo8evJFFXsDLKWizWnrNRtCFTb+Cp66KsYeoU
         5msw==
X-Forwarded-Encrypted: i=1; AJvYcCXEbSF2TJYKKhykg6nu+gWHsngMCxKCmJyd0LWPk+YfmRvgqMIx2D37bEIgu1qM4/BfuOv7ICTI6Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzrFBzL15afQTLsnWYeogZmkwxGL5stAs9Y8NdP4txf5DYTW5u6
	Cyyb7Uk7ikrQaQQJir/x6qsICETnIRR8Vl1EtOvMP0rF19uVyOA3CCm97wgphsT4oUrR4kGi5w1
	qkG7skB0FLnb5o7wlZofZ8SVeG5OTqgV5o93HHnxd
X-Gm-Gg: ATEYQzwTYApIrRmVVN8eJpyhpdRL/3rP4EKosnyIvweDqpUBc69ohbMussGe/+wwCFn
	6FWKW8eOwcN63exLdMJyd/n9xRYaidpkYgx7HvwA3B3cYQUy7YhWNQjZdt7oepQG47Cl4XHUvzN
	zXFIPQLG04AhVbgaZwd+yaO5uPH16rOhU2Hs8kqi3oUnfRcIB9yXXHOrDhKq3JBEvXRdGTbTPBi
	V4GYdDbFT8qP8lL4FJN1RPS/Kch6E0FWHowZjmKdONb/S3f5EHguntxOeQKdXnF+hc5Yfrf/afv
	FN1Oln62wAfw3pNRZsuJRRGtWJ3VFeyN8XiYlh/D+xm0uNdLPOTKidMHEb2Rtg5c8+xflrUNAyk
	mpsoxSTSJQRjBdwfeqRKY3EfH
X-Received: by 2002:a05:622a:4cd:b0:503:4bc:c925 with SMTP id
 d75a77b69052e-50926fff37amr480231cf.13.1773078297667; Mon, 09 Mar 2026
 10:44:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1773075892.git.berto@igalia.com> <ef5a7c5e3e3dbd17dcb20efaa0c53a47a23498bb.1773075892.git.berto@igalia.com>
In-Reply-To: <ef5a7c5e3e3dbd17dcb20efaa0c53a47a23498bb.1773075892.git.berto@igalia.com>
From: Brian Geffon <bgeffon@google.com>
Date: Mon, 9 Mar 2026 13:44:21 -0400
X-Gm-Features: AaiRm50s1zMOlR2emdzaCgLy9ah8UEouDE_R3lOTyobeO8QBcmv_uKLu7jZyPnY
Message-ID: <CADyq12xmsk8DoW328dV8GZkcnSu7q4ZqeC21xauMbsN=txDi8w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] PM: hibernate: Drain trailing zero pages on
 userspace restore
To: Alberto Garcia <berto@igalia.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 490D123DCCF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43964-lists,linux-pm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bgeffon@google.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,igalia.com:email]
X-Rspamd-Action: no action

On Mon, Mar 9, 2026 at 1:40=E2=80=AFPM Alberto Garcia <berto@igalia.com> wr=
ote:
>
> Commit 005e8dddd497 ("PM: hibernate: don't store zero pages in the
> image file") added an optimization to skip zero-filled pages in the
> hibernation image. On restore, zero pages are handled internally by
> snapshot_write_next() in a loop that processes them without returning
> to the caller.
>
> With the userspace restore interface, writing the last non-zero page
> to /dev/snapshot is followed by the SNAPSHOT_ATOMIC_RESTORE ioctl. At
> this point there are no more calls to snapshot_write_next() so any
> trailing zero pages are not processed, snapshot_image_loaded() fails
> because handle->cur is smaller than expected, the ioctl returns -EPERM
> and the image is not restored.
>
> The in-kernel restore path is not affected by this because the loop in
> load_image() in swap.c calls snapshot_write_next() until it returns 0.
> It is this final call that drains any trailing zero pages.
>
> Fixed by calling snapshot_write_next() in snapshot_write_finalize(),
> giving the kernel the chance to drain any trailing zero pages.
>
> Fixes: 005e8dddd497 ("PM: hibernate: don't store zero pages in the image =
file")
> Signed-off-by: Alberto Garcia <berto@igalia.com>

Acked-by: Brian Geffon <bgeffon@google.com>

> ---
>  kernel/power/snapshot.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> index 6e1321837c66..a564650734dc 100644
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c
> @@ -2855,6 +2855,17 @@ int snapshot_write_finalize(struct snapshot_handle=
 *handle)
>  {
>         int error;
>
> +       /*
> +        * Call snapshot_write_next() to drain any trailing zero pages,
> +        * but make sure we're in the data page region first.
> +        * This function can return PAGE_SIZE if the kernel was expecting
> +        * another copy page. Return -ENODATA in that situation.
> +        */
> +       if (handle->cur > nr_meta_pages + 1) {
> +               error =3D snapshot_write_next(handle);
> +               if (error)
> +                       return error > 0 ? -ENODATA : error;
> +       }
>         copy_last_highmem_page();
>         error =3D hibernate_restore_protect_page(handle->buffer);
>         /* Do that only if we have loaded the image entirely */
> --
> 2.47.3
>


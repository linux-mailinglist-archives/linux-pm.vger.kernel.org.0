Return-Path: <linux-pm+bounces-43578-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEoWOHkdqGnyoAAAu9opvQ
	(envelope-from <linux-pm+bounces-43578-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 12:54:33 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 890C91FF5D1
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 12:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD3B130514B3
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2026 11:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8EC3A5E77;
	Wed,  4 Mar 2026 11:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k4MudI2c"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571CA39FCD1
	for <linux-pm@vger.kernel.org>; Wed,  4 Mar 2026 11:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772625131; cv=pass; b=ldQWqbR1oKTGbY1o/RM5lJqdBzlCxpOSx2/czPfHrfpLOiFpyE8BfdXU47SlWU95BHtv24YbpTg8UBdaYeGcqNH0OQud1yFGMSdpGMPkUXYKkZwKH1EUuF6/pOx8pj/qQF+yPmlZhGH4eJdWWDIc3O+dhyQ1eev/Ruxq4e0+fic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772625131; c=relaxed/simple;
	bh=89nhl3kHx/o/l2BP+mQCx42eqbHpoo6C1RBMLf+6uyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CuTBLVE9j6afLv3I+7ogcL/plsOlp5PIlPQlfWedCCuKofELbzmQvTvvD/LWTQUWXMzSjeuGhY/N6fWFMxF4i7JvPzYaXlv6fyIEzek1bye0XXsMMLwrzjoNoi8QdwOzg/+rdoSGJouMGfpx/TtnxGQXygzDxrCsW6X6VMpUV5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k4MudI2c; arc=pass smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-389e71756d8so128935301fa.2
        for <linux-pm@vger.kernel.org>; Wed, 04 Mar 2026 03:52:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772625127; cv=none;
        d=google.com; s=arc-20240605;
        b=P6cCeJFzgFl8YPCDMErc+m8sBsleEF36BDgjIqJD6uHKBw3CULG4+3oJYZbuJv/M9Q
         kChB5tGGn9zGynJamrcEDIyS1dY4N9pT21vJxIl2hqBwRzUjK65eyisoQ+UzzwE/sBJh
         8CIKabX/jJC5sGuYXjxnPBFAiJ/KbqC6G1JbJ91dBwAiH/LxRQl39dwnV6l+6YwjNAG0
         CZO31dLoHckmcUf6fimzoTS+JqC1pOGddv7JlPkR3sEwVkphIQHkl228kWd76JL/KeoQ
         3/YCkRPptdCRaRKxSyYvxzEWyJBKJHu9rmIS9h5NUVhRausQ3zgH1bbjxTPxyXrIbN6c
         0rhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=bokPD3BMNns3x1kZqoCBsT9+nMQiuj/clSnCRy4TfZI=;
        fh=Z+FK28TTsgfxGRemDGkb5wUVf3j1yoBXrVSfTh4WXe4=;
        b=KEaw2SNJu6p9Jp20vRFT3tGqc6udiObXgWTIgQzSnBBuxainMrIQ3cXcspO1IRxIcU
         Xrvn891vC5yrOmJVQg/dy8Fx60md+QJnIUJPWXuIjlC192iwU+G7nGrvCNvxwq0s152l
         s18uGGVppAcSajQ7+7RWKq0OawMbDCkaXYB3HSLYPUQkFvzoF1ppACzoFrvBsndVKivx
         MyU1eMfHkWViGtOvf0Dx1VkR62g0ivgwqxD/Qy2VQcYPyhXJffPsAPHT60tjH/tBKLv9
         oa2W24q30u981bLpCRkUlQeYpHZ6E4ESUJR/QgBoGQFR7KTJ41xBxQYIBUQ/WL9U4xqd
         6aOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772625127; x=1773229927; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bokPD3BMNns3x1kZqoCBsT9+nMQiuj/clSnCRy4TfZI=;
        b=k4MudI2cBP+H60L8Sf3oOxZrlsN+eTAr/MFpzaFQ14/41ZKSxP6sYUJ58LEkQPJNgo
         X8zw9jDN+ldYOD0EerKlMU6WWLQv/e/2vRyqL4PdP/UkXY5aGFwuaCWvcr6DChtNTFlW
         5jGpivfL5IxE4vWC0ZqOuNmpKA0zOzavvgNOU21lBx1S4UtALdjgxpWbokLixjHfTfIa
         H5E6eGxvuxhUi9mDv3Pjn5sdtNA1bZ+WdndPazv7IhiAgNB76EKADt4A/Qz1pqFjp19V
         6vZwYpTjc02XPmo37hcqN/UhnyLsaEdMLELgnpEXtl2iHBoibPORhOl+HRHkVGMIz233
         8Mrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772625127; x=1773229927;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bokPD3BMNns3x1kZqoCBsT9+nMQiuj/clSnCRy4TfZI=;
        b=U6QWrrPqOja4c6vu5t0AEMwM3K6cnHLRU1Jp97Y6qTq6BvV0J1jpimehBwzfKI2MR8
         1m3DmfqoURW1zyHrAj/QYV3oKJ3c1tqG37MEmxvQrIpERQZTrfhPt1Q64Rdhwi8OS/Js
         jY9LG1jGw5KpoFmViAugn4uyP80QWxbn83udZJUlmOB6yO/XdsW5OYwJomtKRyakve0V
         Yupv9d3rAXFKbCWG9vHxd4Jm4zEi1R/AyDCz6pWgbgvap/W/LTiOZH72Ex3xIjDeHaO5
         fE6CkNKmeLtoAHP66Ma5R3PbX/cUns4OzM++F23LZ3tDE4I6FM30SupI9IdnqNiZxXhO
         rr/g==
X-Gm-Message-State: AOJu0YysshBydkOnZvmO3NFRJ4M0ieu3lQCHCERNnthhaTQauB9Iju2J
	6i3zibwtxGqsAFUUZVjf5YNWes3hbsbECsDfSj37Tkw63vFbbM4VyW39WbV1Vk0xtIxyzrreyOx
	Q65U7Di7ef105PtboLj8JOEdi0FqSHP2AA4wzMchvFw==
X-Gm-Gg: ATEYQzzXAm7T+wIvaXtos0IzLTjP1oQLTuKSGffRTma+uqLoWxM5EVnh8DqKFjij42y
	/mc55sUdlr4PxLNQQogaa90PgJ59GJviUf6siVoinARX32QjHVGVib8dvdkjjRt8fEuvtK5EdGu
	k16vGNP8hwwdVKD/d4IBuzCv3fMIVPVIe3U6CKPMXvtY/6UzYa0iekl2og8cuNXlkTZFkxemZJj
	WRlU0RCl1b1LS9VSO8Pn2xTtDZuXA6lZdMo38KjOpkIP5wqEXrJgQlA5KmnkH5m58KKpm3uXyFf
	6Xm9MJxD41hrPynRj18=
X-Received: by 2002:a05:651c:110c:b0:386:ee99:6cb3 with SMTP id
 38308e7fff4ca-38a2c574c04mr13141631fa.9.1772625127349; Wed, 04 Mar 2026
 03:52:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1cfa86b72b2a5aa2ade92f247dd318c9cb6ef2a1.1771267504.git.geert+renesas@glider.be>
 <CAPDyKFotV3bUEQic6X3PEC8m4fcXtc0JF0u7HTj9nRF1koowgA@mail.gmail.com> <CAMuHMdUwLqWxp1pYj3fHf6OVtxrScg=wP=bdwLbjo7vpgmP4Jw@mail.gmail.com>
In-Reply-To: <CAMuHMdUwLqWxp1pYj3fHf6OVtxrScg=wP=bdwLbjo7vpgmP4Jw@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 4 Mar 2026 12:51:31 +0100
X-Gm-Features: AaiRm51AEYQZCHawi9S-OmAkgl7UCrfFFz9JqnTGEGT0Np2553dLVerq52x8hOk
Message-ID: <CAPDyKFq2it5TAEBBKBh+q+UiRsGYaORar0Q_42LCuxyKRLYj0A@mail.gmail.com>
Subject: Re: [PATCH/RFC] pmdomain: core: Support pd_ignore_unused with sync_state
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 890C91FF5D1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43578-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[172.234.253.10:from];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ulf.hansson@linaro.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[100.90.174.1:received,209.85.208.180:received];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:dkim,linaro.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Wed, 4 Mar 2026 at 12:06, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Ulf,
>
> On Wed, 4 Mar 2026 at 11:56, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > On Mon, 16 Feb 2026 at 19:47, Geert Uytterhoeven
> > <geert+renesas@glider.be> wrote:
> > > Since the introduction of the sync_state mechanism, the
> > > "pd_ignore_unused" kernel command line option doesn't really work
> > > anymore.  While genpd_power_off_unused() still checks for that flag
> > > before powering down unused domains, the new sync_state callbacks lack
> > > such checks, thus powering down unused domains regardless.
> > >
> > > Fix this by adding checks to the sync_state helpers and callbacks.
> > > Factor out the printing of the warning message, to make sure it is
> > > printed only once.
> > >
> > > Fixes: 002ebddd695a5399 ("pmdomain: core: Restore behaviour for disabling unused PM domains")
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > ---
> > > RFC as I have no need for this in upstream.
> >
> > I am trying to understand the use case and whether we should consider
> > to land this upstream.
> >
> > Would you mind elaborating on how this is useful for you?
>
> It is (currently) not useful for me, but it may be useful for others.
> During work on a new SoC, someone had hardcoded "pd_ignore_unused"
> in the kernel command line.  After adding support for PM Domains on
> that SoC, I noticed PM Domains were still powered down.
>
> The issue is that pd_ignore_unused no longer does what it claims to do:
>
>         pd_ignore_unused
>                         [PM]
>                         Keep all power-domains already enabled by bootloader on,
>                         even if no driver has claimed them. This is useful
>                         for debug and development, but should not be
>                         needed on a platform with proper driver support.
>

Well, this is exactly what the sync_state mechanism intends to
address, but in a more correct way compared to pd_ignore_unused.

If a consumer device that belongs to a power domain, lacks a driver
(or it never probes) then that power domain will not be powered-off by
genpd (if it was on a boot). For the pd_ignore_unused case, we may end
up powering off the genpd anyway, becuase child-domains being
powered-off, for example.

For incomplete drivers, the assumption is that the device attaches to
its genpd but runtime PM remains disabled for the device. In these
cases, genpd will not power-off the corresponding power domain.

> So IMO that should either be fixed, or the option should be removed.
> Do you agree?

Right, I think it's time to consider removing it, unless people still
find it useful ofcourse.

Do you want to send a patch that we can test/review or you prefer me
to handle it?

Kind regards
Uffe


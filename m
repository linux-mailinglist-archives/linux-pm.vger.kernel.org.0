Return-Path: <linux-pm+bounces-43571-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EP0QKMESqGnUngAAu9opvQ
	(envelope-from <linux-pm+bounces-43571-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 12:08:49 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A751FEB16
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 12:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D39030459F0
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2026 11:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CD639F172;
	Wed,  4 Mar 2026 11:06:27 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38943390993
	for <linux-pm@vger.kernel.org>; Wed,  4 Mar 2026 11:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772622387; cv=none; b=Mo/Esa7nu9dyLuGzmKwQ6oVHMzYDv8dLFgKpw+0E/w2XJ+eA9ute7R56rGYoRNY4O0koO/h72h6mQ3PG21ewRYqqXjKy0CXeHFcIwCfEk4djCTQbELCtxF11prUXKeFQWEtp0vOWxmr2GV20mXUdjlD/1XPH+4LPxqb8trU9bEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772622387; c=relaxed/simple;
	bh=h4xGx8Lo/3rAAkJbNp4e33YxvrMf+pmcL7aFTI610mE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G2n//+r6NM0g296egAu30pfnxZaoJpdb8l5vx54WkVr/cAeGExPpEM2hmzJ490sDqsyllosVXW7fBDxbqaakgAJedphiDKz2xncHHbA7z5SBUSiwbduqyd8Qe9NXvo4oH8FHxFZbxaEFzx3vJ4fAVZeU7OuvUkGe6bqzplKR3LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-56a88bfd470so5323229e0c.0
        for <linux-pm@vger.kernel.org>; Wed, 04 Mar 2026 03:06:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772622385; x=1773227185;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bc1lWKqwyxd1K+z/jMu8xneXJ1RZxhNWU8LvY2R0KKY=;
        b=E0J566AtqRNvVK9+qFTtlIIZA0/8urO+QIIGYdQnKce19byWVfF6bsm/hed/fWFdmk
         xFIeu14dkSzaHt/jrjQtt+9izCx0+fon1koYuGE4JWqdQ38RplxnH9hcfFTMxR0rNEvO
         hqaXY7ckMzaKqoSr4S0MMkw1kMau/EK64TrCi/UJdyFtObL9ZUpVKEVW6/70FhRUner0
         40gdIX1977TtDdOH30O4JOCdhSpb+kJlxytW+9tFMlNe6iViZc0tQrI7XnO4a3KgBOb1
         IqHme+Cil7w9TZ6VzCI0bXdrU0mu4WGz97Y4cowdk20wx+jKfNxyShFI0ZMv3FS15rEQ
         qlsA==
X-Gm-Message-State: AOJu0YwEdVEY3yUtO9VU1kft/nuC4meVnqkQIsTq8iRotygkEv1MYq6p
	8JfM0AjQl7ew2y1Vchlth5MmbxEtIVLh3N2brTNkOuhNvsV7YiDkeb1SDwxKHrOo
X-Gm-Gg: ATEYQzwoP73sit6nvlQTMzWn55xzVPvAV4gA03VNtgaGKk2cPfkqMvfjOgWqN30Q2ax
	wnXbmmVVsK0hJhyTo8jv0kCrfOmyghSfxOOMx8AcCzgYBqb1Gm7v01o/uUsbCAUHTH+PouoFT3/
	a5MOLwbgCOIjen6MOfzHoHygIIM+pYMIkKNUXyH0Bsr9jlNA/vJOyiQzg6i5tvW/dxfXGTntXxx
	xsrGvUFpz17yM8PeiDalcEF+8ivrb2VYruRaCbvXZZ3eP/qg12AZ3vZjJpq07N+DJneVNofyVSK
	/BC8DB/LERGJDF3NkjHYnXYm5rCrs5w278AujSOXYPPCKg9k9E23TNLupG2QR/14fTqeYh7i6z+
	zYB3Yhonv8Z+HLjuxIIuNn+7gp2uHYGeEiWwjhOWYbgYmL4FG0UcOu8GfT25kb3AlX4AUVfIa3c
	2tisdvhExSUcTbUeuf7jUH/gRV5pgim1TVtwzXguRqsVzeuV3QzukbBkAhBGmT
X-Received: by 2002:a05:6122:4d19:b0:55c:be5e:e9e9 with SMTP id 71dfb90a1353d-56ae7eae6e2mr638202e0c.1.1772622385173;
        Wed, 04 Mar 2026 03:06:25 -0800 (PST)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56ae7a29c2esm1564099e0c.7.2026.03.04.03.06.24
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 03:06:24 -0800 (PST)
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-5ff9d047981so843185137.1
        for <linux-pm@vger.kernel.org>; Wed, 04 Mar 2026 03:06:24 -0800 (PST)
X-Received: by 2002:a05:6102:c04:b0:5f5:3739:100d with SMTP id
 ada2fe7eead31-5ff8f555c1fmr2447437137.0.1772622384397; Wed, 04 Mar 2026
 03:06:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1cfa86b72b2a5aa2ade92f247dd318c9cb6ef2a1.1771267504.git.geert+renesas@glider.be>
 <CAPDyKFotV3bUEQic6X3PEC8m4fcXtc0JF0u7HTj9nRF1koowgA@mail.gmail.com>
In-Reply-To: <CAPDyKFotV3bUEQic6X3PEC8m4fcXtc0JF0u7HTj9nRF1koowgA@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 4 Mar 2026 12:06:12 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUwLqWxp1pYj3fHf6OVtxrScg=wP=bdwLbjo7vpgmP4Jw@mail.gmail.com>
X-Gm-Features: AaiRm51l8HwBRY_tDhyX1MH5hQpu6lRSnZBK8l-db6--eDbumd1dAL9LGKVifxA
Message-ID: <CAMuHMdUwLqWxp1pYj3fHf6OVtxrScg=wP=bdwLbjo7vpgmP4Jw@mail.gmail.com>
Subject: Re: [PATCH/RFC] pmdomain: core: Support pd_ignore_unused with sync_state
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 43A751FEB16
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43571-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.919];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[glider.be:email,linux-m68k.org:email,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linaro.org:email]
X-Rspamd-Action: no action

Hi Ulf,

On Wed, 4 Mar 2026 at 11:56, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On Mon, 16 Feb 2026 at 19:47, Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
> > Since the introduction of the sync_state mechanism, the
> > "pd_ignore_unused" kernel command line option doesn't really work
> > anymore.  While genpd_power_off_unused() still checks for that flag
> > before powering down unused domains, the new sync_state callbacks lack
> > such checks, thus powering down unused domains regardless.
> >
> > Fix this by adding checks to the sync_state helpers and callbacks.
> > Factor out the printing of the warning message, to make sure it is
> > printed only once.
> >
> > Fixes: 002ebddd695a5399 ("pmdomain: core: Restore behaviour for disabling unused PM domains")
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > RFC as I have no need for this in upstream.
>
> I am trying to understand the use case and whether we should consider
> to land this upstream.
>
> Would you mind elaborating on how this is useful for you?

It is (currently) not useful for me, but it may be useful for others.
During work on a new SoC, someone had hardcoded "pd_ignore_unused"
in the kernel command line.  After adding support for PM Domains on
that SoC, I noticed PM Domains were still powered down.

The issue is that pd_ignore_unused no longer does what it claims to do:

        pd_ignore_unused
                        [PM]
                        Keep all power-domains already enabled by bootloader on,
                        even if no driver has claimed them. This is useful
                        for debug and development, but should not be
                        needed on a platform with proper driver support.

So IMO that should either be fixed, or the option should be removed.
Do you agree?
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds


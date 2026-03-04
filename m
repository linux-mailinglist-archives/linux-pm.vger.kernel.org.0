Return-Path: <linux-pm+bounces-43579-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOHlGlEpqGkdpAAAu9opvQ
	(envelope-from <linux-pm+bounces-43579-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 13:45:05 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8CF41FFC73
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 13:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47D643015894
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2026 12:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E371DE8AE;
	Wed,  4 Mar 2026 12:45:01 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318DE1B4156
	for <linux-pm@vger.kernel.org>; Wed,  4 Mar 2026 12:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772628301; cv=none; b=opCxKZ79nreQZjhgcynQOjjPf7qFGdMqTACgDFXHowJX/kvuZt7543tt1MDkTupEDDBLt+dwiYp4HzRGoIQ32l/j9G5AoxgAuMCFnSb5qR/ylQU4JHcYyDjgd0nG3yc79gU40OfNxtEYnDJx1+FYtKNav87bL/i5tYKh1VilSLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772628301; c=relaxed/simple;
	bh=3Mro9ieTCWZnccA7uYcdmNAs151qBip0jfucMzPC6HU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UlL8HZfuJAVcB6CascHCDAb1zD7fEm39iDAaFuNZw5cQSFguhWhLaYyl/K0KYbA1Au1u5Ac7oi+ahe6jXftMmtOegzvdmxdKFpwVHvSN32MCv+NDWNDA3FjTo+Wr5uHQBLZb5Rw3uhQPDmGyxSpo/K42nHc5Da+o34iSNdL1Mb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-5ffb61b0babso220981137.3
        for <linux-pm@vger.kernel.org>; Wed, 04 Mar 2026 04:45:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772628299; x=1773233099;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5jOJis2k42MuXRJfCHvO4iLfTzm70s8fuGt1UGFetG0=;
        b=l/LYZ6scQ6gsO5o5uPMm70wtxMYqDp1anFDPJ7k7NYJ1ocyw/wLU11G+3OQThXVnvB
         y8/3tbsdeU1mzjjTk2rfKfJROGjF29bmUejtp+E0+yBVSyqAuaF+Jy0zMZdtYZDe2RLx
         shP6w+aJAfTRIC7K8W/WXCeExR/jcbIQw0b1kTLo9i5FUvWvuREUeBXbcmaIQGebHz8g
         oEgx2mw8TqlStRfqUmLWGeuoBbNgR9jiqoaik3VgPP40A5HbHTCrfXYnu8KS6SL4pZYb
         KDG8YFPa7Td2VICYprfLg/F8b4/eQ/u2Py/uJtpQGyzhHU+Wbvmx0iUpBDC7rcLMxKgn
         mf1g==
X-Gm-Message-State: AOJu0YwcMC8MurMC7CAugMDeUfOSnVzuceN4UCIXXQiY6x94bjtnY3Q3
	SGGkMvviziSJVM9g943G6wURSV5FZikWArwhlMzgULnI9JkZe4KWhBCeQyzwgwNm
X-Gm-Gg: ATEYQzxEXLVA7Aww555pTH/iFZzIe3rFxPvLa9u+9WcOWY3Za1dhvP2Ue1/3Vgy6z68
	x01WMjyJsxI8wEAm1kwWzx86tl8EWtILF6uyzWFxqjkcanLfntJUBzy8dHzAOqA3QMnKU6Y3kzW
	CJTt+qy9G4ptJWe3b+M033jw92BD8DxQW3oCJoVndlh9ByM1lyuUm63YQLIi+Ox99UyE5rZs4g9
	nxF4ziknMZBz573e7B8WJ6ximyedeR9Xy3VTfNCHmqaNvq+25r2T1Svtn3hbXMdQ52uaS3tNZt6
	oO89lSbh7nmAZyW3L9O/rJaQcejV7p9mb6ofGn5xta/8bKZyp4VzaLj+n6KdGboPqFCPz3NXcwI
	5hQ1t/ccArqz6kgr1zQkFI7NsNy0+4hqhAvo7tBM50nBSdcMjE/kNvyEO8IRcbHARlKrc5sLbMN
	lZKx4mWNeXdK4Zcp6e2AnRG2jrDyq0k599g/WvvJXeVH94QWF0QhjnbITGNKRn
X-Received: by 2002:a05:6102:cd2:b0:5fc:2b29:b005 with SMTP id ada2fe7eead31-5ffaaf469b2mr766421137.24.1772628299125;
        Wed, 04 Mar 2026 04:44:59 -0800 (PST)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ff1e808164sm20153747137.4.2026.03.04.04.44.58
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 04:44:58 -0800 (PST)
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-5ff174502ffso4801528137.1
        for <linux-pm@vger.kernel.org>; Wed, 04 Mar 2026 04:44:58 -0800 (PST)
X-Received: by 2002:a05:6102:d93:b0:5f8:e54c:2f72 with SMTP id
 ada2fe7eead31-5ffaaf499d5mr808375137.20.1772628298656; Wed, 04 Mar 2026
 04:44:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1cfa86b72b2a5aa2ade92f247dd318c9cb6ef2a1.1771267504.git.geert+renesas@glider.be>
 <CAPDyKFotV3bUEQic6X3PEC8m4fcXtc0JF0u7HTj9nRF1koowgA@mail.gmail.com>
 <CAMuHMdUwLqWxp1pYj3fHf6OVtxrScg=wP=bdwLbjo7vpgmP4Jw@mail.gmail.com> <CAPDyKFq2it5TAEBBKBh+q+UiRsGYaORar0Q_42LCuxyKRLYj0A@mail.gmail.com>
In-Reply-To: <CAPDyKFq2it5TAEBBKBh+q+UiRsGYaORar0Q_42LCuxyKRLYj0A@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 4 Mar 2026 13:44:47 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVYydpHzVCyCWjM97R72Kw7CC_yixh90Xkdx7zTFLrp1A@mail.gmail.com>
X-Gm-Features: AaiRm50ns5ZCriEiTsGAXYy21SfUlanA_iiWCQM7_dyXADpF8EAVg--zFZV8C4o
Message-ID: <CAMuHMdVYydpHzVCyCWjM97R72Kw7CC_yixh90Xkdx7zTFLrp1A@mail.gmail.com>
Subject: Re: [PATCH/RFC] pmdomain: core: Support pd_ignore_unused with sync_state
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: A8CF41FFC73
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43579-lists,linux-pm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.919];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linaro.org:email,glider.be:email,linux-m68k.org:email]
X-Rspamd-Action: no action

Hi Ulf,

On Wed, 4 Mar 2026 at 12:52, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On Wed, 4 Mar 2026 at 12:06, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Wed, 4 Mar 2026 at 11:56, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > On Mon, 16 Feb 2026 at 19:47, Geert Uytterhoeven
> > > <geert+renesas@glider.be> wrote:
> > > > Since the introduction of the sync_state mechanism, the
> > > > "pd_ignore_unused" kernel command line option doesn't really work
> > > > anymore.  While genpd_power_off_unused() still checks for that flag
> > > > before powering down unused domains, the new sync_state callbacks lack
> > > > such checks, thus powering down unused domains regardless.
> > > >
> > > > Fix this by adding checks to the sync_state helpers and callbacks.
> > > > Factor out the printing of the warning message, to make sure it is
> > > > printed only once.
> > > >
> > > > Fixes: 002ebddd695a5399 ("pmdomain: core: Restore behaviour for disabling unused PM domains")
> > > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > > ---
> > > > RFC as I have no need for this in upstream.
> > >
> > > I am trying to understand the use case and whether we should consider
> > > to land this upstream.
> > >
> > > Would you mind elaborating on how this is useful for you?
> >
> > It is (currently) not useful for me, but it may be useful for others.
> > During work on a new SoC, someone had hardcoded "pd_ignore_unused"
> > in the kernel command line.  After adding support for PM Domains on
> > that SoC, I noticed PM Domains were still powered down.
> >
> > The issue is that pd_ignore_unused no longer does what it claims to do:
> >
> >         pd_ignore_unused
> >                         [PM]
> >                         Keep all power-domains already enabled by bootloader on,
> >                         even if no driver has claimed them. This is useful
> >                         for debug and development, but should not be
> >                         needed on a platform with proper driver support.
> >

[...]

> > So IMO that should either be fixed, or the option should be removed.
> > Do you agree?
>
> Right, I think it's time to consider removing it, unless people still
> find it useful ofcourse.
>
> Do you want to send a patch that we can test/review or you prefer me
> to handle it?

Feel free to handle it.
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds


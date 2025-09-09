Return-Path: <linux-pm+bounces-34252-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF0EB4FB93
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 14:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0205B4E3191
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 12:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A67332CF97;
	Tue,  9 Sep 2025 12:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kA6hZt7A"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DAB25A33A
	for <linux-pm@vger.kernel.org>; Tue,  9 Sep 2025 12:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757422016; cv=none; b=e6iDZVMNdElCFyH9+gI+YUoX5hqVVByuE0/zXb9OgWXxXxDYmG9tTCPeI9trStLOxQUE+He6dleJQA5wuGHvXYdm6OQF2mpB6jZ9XF6yxPnRrcxzfOtPiFepulBaD9CFGNXINp1k/8oe867Of1n8gX9srFP6ANRh+q35xRmdRCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757422016; c=relaxed/simple;
	bh=//twNMkSXAG5ejIriR3b6wzGwhPGSwA6C+hPQCcT4rQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uM0HR0oD7uegp08QNrM+ElAMbpIxidJelNOoKrkJJrmK2kVqdGiMDJm4+8lUvSY8qntFhZ7QXp2cyQeVIfBqEtc3yHxzVnG4s7E/SGy5BjJadffx8/bJR7Uwn2aQXln0i0QofuE7In7bqvrTPEKBdXYS+0b5pwJWvTzwJTnuxmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kA6hZt7A; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7238b5d5780so54678527b3.0
        for <linux-pm@vger.kernel.org>; Tue, 09 Sep 2025 05:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757422013; x=1758026813; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=//twNMkSXAG5ejIriR3b6wzGwhPGSwA6C+hPQCcT4rQ=;
        b=kA6hZt7AprjowNCxNSe+b7DEtGBMVuTrrCY7DDPPuGouU4NmoJ+Q1AJjcw30R3LI2q
         e/DisMe9rbTtHCSBFPDQeZ3VITaS+LBNx/v1tdo5IduHRruX8Zrr3ck0ecxlH6gAlGna
         eVT/XbygWN86gTxc5IrYin3RVlWY7+8lAIQp0os+KBrxsBzme4Wv8X4w9Q7V9RCuPLdl
         3HxyU2RBkR7BiOXIywyPeYDvvnbgiu9zyyU+EbmEeFka2yCB9eQODBFqRC/tDjjbsLAf
         CtoGvbLAmjvkMhHsGtxr3yD4ck2vApLmAUWosxABCfIG5sf9ozsVN4T/8gtdF5yqltxt
         ECDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757422013; x=1758026813;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=//twNMkSXAG5ejIriR3b6wzGwhPGSwA6C+hPQCcT4rQ=;
        b=r6VWO9jbrB6kxESFHcN80KeIWyRJtMvY+aNdocSr1iHCRp1UqeMHIa3GfJOr3EAT3D
         iai/ufWMtEYpWbex9pCCLADekW5o47D8YrAypSru28LeUshMzZSJS6RmOcjcgbpKAcdu
         UR607pvQggVSpF/4SvUevmnWw2LkgQ87kpoH437ZJHenehVMhRSDoWEzfnf30z2Giihq
         w7BYBE/E7JlJAd7D287fByOHQa8GxlaZKLqzTGTB1vKOGcFXZcgzEnnY1+519yTudxXH
         tF2AX5AmQfJU1nHJ5eGqamr1ANRNaOKIPzR3SxZ80g4Euo6/ysDrN4iYfoHSooGDKEba
         5PLg==
X-Forwarded-Encrypted: i=1; AJvYcCUyEsU5KuwNCWFZ89Ltr7n0OhpK5hEq/wq94Y/dHrRDFbZzda/DC38kDY8UND1I+954eeFbrDxjhg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzByUHTjilfyYJ7Xsz6EnnxwghkjR5tbTigisrM3ku1f1PGq30m
	66kbzEPp/Qha6bfGaAuenVneVMlbOKhbZv4JA3jo1arvUSciQXD+6PM4P3gV5BCXlMSHmz6RWzM
	FpGlj2YeokXloV6kgdU+lG3fKBF1rRJRvxHCfP3/feA==
X-Gm-Gg: ASbGncs+bKSOZoxgY8zOsd4Z01elZ9Cd6Qob0xYGm25dOveW38m+wFZ/mx5Wbc0kzvs
	MS5o3mC/GT0AsYWq7sO8YX8j6uZyoSz+rtM/PvkJAuXNmjgQh3u51HhKwXXChlcOQkKr+QGy9Pg
	eMU3rUwg6c8ATNrkl3PrqZGrUF5b/uXrV9Y2qhE01xmKe4x7LkGhi+6wsovXyuwmZieVxbtLzkt
	DNKZhKy
X-Google-Smtp-Source: AGHT+IF6coC5AISKfPvkfbCW5yoYd2AYD5TB7N0tawVxrBibg84uognIosWnLcfftKSvGrvcJLOCTDCRDYDlkUXV5Ag=
X-Received: by 2002:a05:690c:a015:b0:729:5b86:551c with SMTP id
 00721157ae682-7295b865879mr75579857b3.0.1757422013421; Tue, 09 Sep 2025
 05:46:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902-rk3576-lockup-regression-v1-1-c4a0c9daeb00@collabora.com>
 <3556261.BddDVKsqQX@workhorse> <CAPDyKFpSY+FeKh7ocjQ_nGNZA5+3tWAL8e7ZNKXKNFP-yoiu_g@mail.gmail.com>
 <1953725.CQOukoFCf9@workhorse> <CAPDyKFofhy5wiNsHUgdtzFwGtO3QPqhVuu1KsPLBWHF08JzqyA@mail.gmail.com>
 <dr5qspjhwxaxutiilgx4rvfbrho4bijoll6lciv2bc7c7e7r7m@pgmxztqje5ux>
In-Reply-To: <dr5qspjhwxaxutiilgx4rvfbrho4bijoll6lciv2bc7c7e7r7m@pgmxztqje5ux>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 9 Sep 2025 14:46:17 +0200
X-Gm-Features: Ac12FXwo4_-4PiymUqOxTae5p_ZC6h14IgeNt4w4eS7V2OTdZjnLF13VxirAI10
Message-ID: <CAPDyKFr=GwJ+cO3cW4Ed_LsS=q_JtuuQPDweDpLgDO4hBLFXUA@mail.gmail.com>
Subject: Re: [PATCH] pmdomian: core: don't unset stay_on during sync_state
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel@collabora.com, 
	linux-rockchip@lists.infradead.org, 
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, Heiko Stuebner <heiko@sntech.de>
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Sept 2025 at 22:09, Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> Hi,
>
> On Mon, Sep 08, 2025 at 03:40:24PM +0200, Ulf Hansson wrote:
> > On Mon, 8 Sept 2025 at 15:14, Nicolas Frattaroli wrote:
> > > On Friday, 5 September 2025 16:27:27 CEST Ulf Hansson wrote:
> > > > I would suggest implementing an auxiliary driver, along with the
> > > > rockchip_pm_domain_driver. The main job for the auxiliary driver would
> > > > be to get the regulator in its ->probe() - and if it fails because the
> > > > regulator isn't available yet, it should keep trying by returning
> > > > -EPROBE_DEFER. See more about the auxiliary bus/device/driver in
> > > > include/linux/auxiliary_bus.h and module_auxiliary_driver().
> > > >
> > > > Moreover, when the rockchip_pm_domain_driver probes, it becomes
> > > > responsible for pre-parsing the OF nodes for the domain-supply DT
> > > > property, for each of the specified power-domains. If it finds a
> > > > domain-supply, it should register an auxiliary device that corresponds
> > > > to that particular power-domain. This can be done by using
> > > > platform-data that is shared with the auxiliary device/driver. See
> > > > devm_auxiliary_device_create().
> > > >
> > > > Furthermore we would need some kind of synchronization mechanism
> > > > between the rockchip_pm_domain_driver and the auxiliary driver, to
> > > > manage the regulator get/enable/disable. I think that should be rather
> > > > easy to work out.
> > > >
> > > > Do you think this can work?
> > >
> > > This sounds similar to something Heiko suggested to me, and I agree
> > > it could work. It does seem like a pretty painful solution though,
> > > in terms of needed additional code and complexity to basically just
> > > tell Linux "hey you can't get this regulator yet but please try
> > > again later without our involvement".
> >
> > Well, I would give this a go and see what you end up with. The nice
> > thing with this approach, I think, is that we get a driver and can use
> > the -EPROBE_DEFER mechanism.
> >
> > Another option would be to explore using fw_devlink/device_links, to
> > somehow get a notification as soon as the regulator gets registered.
>
> I think the main pain issue with this is fw_devlink actually. The
> power domain consumers are all referencing the main DT node. So once
> it has been marked as initialized (of_genpd_add_provider_onecell()
> calls fwnode_dev_initialized() at some point), fw_devlink allows the
> consumers to be probed. As the DT node must be usable for processing
> after the normal pmdomains are registered, this means the consumers
> for pmdomains with "domain-supply" will potentially be probed too
> early resulting in some extra -EPROBE_DEFER. OTOH that should be the
> status quo, so probably it does not matter.

Right, the description in the DTS seems a bit odd to me too.

Although I was under the impression that there is kind of a circular
DT dependency here somewhere. Or are you saying that we could
potentially allow those power-domains that are described in
child-nodes to be registered later-on - and after their
domain-supply-regulator has become available?

>
> > I think those kinds of dependencies are better solved by using
> > fw_devlink/device_links.
>
> I think the regulator dependency tracking would happen automatically
> when the auxillary sub-device uses the power-domain sub-node as its
> device fwnode.

Yes, that is correct.

Would that work then? So there is no circular dependency that we forget about?

The pmic that provides the regulator may be behind an spi interface
and the spi controller isn't part of a power-domain that consumes the
regulator?

Kind regards
Uffe


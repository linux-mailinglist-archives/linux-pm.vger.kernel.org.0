Return-Path: <linux-pm+bounces-4477-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C4886A1EB
	for <lists+linux-pm@lfdr.de>; Tue, 27 Feb 2024 22:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19E3C2815BA
	for <lists+linux-pm@lfdr.de>; Tue, 27 Feb 2024 21:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAB614F97C;
	Tue, 27 Feb 2024 21:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZSHRPpK"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEDF4DA0C;
	Tue, 27 Feb 2024 21:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709070559; cv=none; b=N+E5JiTnkFfpoYF7p8EDbRgxPFMrQjUaaDYddyHgSWwUmFSAqk6Kz4E/+cCuXTZoVBoh5Nin1P2MoBdbhXy7NJTF+goQD87lNmNfTQi8OH90tnqf7p0nqrcoVOhAMOFbb8p4KwEv5dtUj6Ks1Hx5z0z7BK9DYLZ1QSVcgCF7XV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709070559; c=relaxed/simple;
	bh=yywVcx58lrrC7hHOpkaIRUe4Yk4DkQzzbNNNfM6vqFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kNUJpiaXlnOdvbcBnAG8Bdh5Y8BPB+PgNHVW+vKMSHUkKMKcqIyRAud8zZDvgEN0Sta7QYIK2tb0xwjMn3nz6cBE/HFunSar6bb3iXitghBK7VAjvMfKZMA3tycdvNeBum6H7hmzUwViqHwRuU0JRNjxdB6SWz3xfVSb9L51IZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZSHRPpK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D647C433C7;
	Tue, 27 Feb 2024 21:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709070558;
	bh=yywVcx58lrrC7hHOpkaIRUe4Yk4DkQzzbNNNfM6vqFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XZSHRPpKfn5/vZqio3VM3gkYjvWmTck2Guj3yKg81q13RX8x57TLLrBK11fT3Y57F
	 HPer7Hv+g1q06tyrUfGCLeI62kN2yeDZaaoseMfVxOUFgsm/jHZUOBin82vcBEhfbK
	 0BRqDc+Okz+o91UkDdFTsAenAY5s3N4FgerMY0mMu0oILuABh4VLwOkkafA1Ovimln
	 /nXlIcjzF6a3zxHN/sjBmrQBod7UQPwVLv4zNlqYu0JRit6q0VyWv50faLbuS0q8Wh
	 x+53hXmF1vgPrljVowyIs3m+F2v/SNDbX5SGAKTE31etL4SG1wjWnVFHLdI7Xf3aes
	 pDrMH7+TCVqtg==
Date: Tue, 27 Feb 2024 14:49:16 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: sre@kernel.org, linux-pm@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH] power: supply: core: Fix power_supply_init_attrs() stub
Message-ID: <20240227214916.GA3699076@dev-arch.thelio-3990X>
References: <20240227-fix-power_supply_init_attrs-stub-v1-1-43365e68d4b3@kernel.org>
 <mlfrfarnnv3i4xwgqd3pavpwxjktkqf2afidoc4ogdq3634jah@kposnyo6725z>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <mlfrfarnnv3i4xwgqd3pavpwxjktkqf2afidoc4ogdq3634jah@kposnyo6725z>

On Tue, Feb 27, 2024 at 05:39:55PM -0300, Ricardo B. Marliere wrote:
> Hi Nathan,
> 
> On 27 Feb 13:34, Nathan Chancellor wrote:
> > When building without CONFIG_SYSFS, there is an error because of a
> > recent refactoring that failed to update the stub of
> > power_supply_init_attrs():
> > 
> >   drivers/power/supply/power_supply_core.c: In function 'power_supply_class_init':
> >   drivers/power/supply/power_supply_core.c:1630:9: error: too few arguments to function 'power_supply_init_attrs'
> >    1630 |         power_supply_init_attrs();
> >         |         ^~~~~~~~~~~~~~~~~~~~~~~
> >   In file included from drivers/power/supply/power_supply_core.c:25:
> >   drivers/power/supply/power_supply.h:25:20: note: declared here
> >      25 | static inline void power_supply_init_attrs(struct device_type *dev_type) {}
> >         |                    ^~~~~~~~~~~~~~~~~~~~~~~
> > 
> > Update the stub function to take no parameters like the rest of the
> > refactoring, which resolves the build error.
> > 
> > Fixes: 7b46b60944d7 ("power: supply: core: constify the struct device_type usage")
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > ---
> >  drivers/power/supply/power_supply.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > 
> > ────────────────────────────────────────────────────────────────────────────────
> > modified: drivers/power/supply/power_supply.h
> > ────────────────────────────────────────────────────────────────────────────────
> > @ drivers/power/supply/power_supply.h:25 @ extern int power_supply_uevent(const struct device *dev, struct kobj_uevent_env
> > 
> > #else
> > 
> > static inline void power_supply_init_attrs(struct device_type *dev_type) {}
> > static inline void power_supply_init_attrs(void) {}
> 
> I've missed that #else in my building test. Thanks for catching it.
> 
> Reviewed-by: Ricardo B. Marliere <ricardo@marliere.net>

Thanks a lot for the quick feedback and no worries, it is hard to test
to catch these without doing a lot of build tests.

Unfortunately, I caught another problem with that change that is
independent of this one:

  ld.lld: error: undefined symbol: power_supply_attr_group
  >>> referenced by power_supply_core.c
  >>>               drivers/power/supply/power_supply_core.o:(power_supply_attr_groups) in archive vmlinux.a
  >>> did you mean: power_supply_attr_groups
  >>> defined in: vmlinux.a(drivers/power/supply/power_supply_core.o)

It looks like power_supply_attr_groups refers to power_supply_attr_group
but power_supply_attr_group is declared extern without a definition with
CONFIG_SYSFS=n. It is not immediately obvious to me what the fix is.

Cheers,
Nathan

> > #define power_supply_uevent NULL
> > 
> > #endif /* CONFIG_SYSFS */
> > 
> > --
> > base-commit: 3da8d71754d3c1aa0b72d74c8a324a4bc7fab473
> > change-id: 20240227-fix-power_supply_init_attrs-stub-7be5328b4e72
> > 
> > Best regards,
> > - 
> > Nathan Chancellor <nathan@kernel.org>
> > 


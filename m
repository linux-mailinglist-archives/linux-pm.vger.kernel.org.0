Return-Path: <linux-pm+bounces-35516-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E7FBA660F
	for <lists+linux-pm@lfdr.de>; Sun, 28 Sep 2025 04:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 70AFA4E048C
	for <lists+linux-pm@lfdr.de>; Sun, 28 Sep 2025 02:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB6724634F;
	Sun, 28 Sep 2025 02:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="FZQFIzS5"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02BA34BA2D;
	Sun, 28 Sep 2025 02:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759025357; cv=none; b=bws6ajoBZoHFsqJVhBD5f0CyuH84VREqftpGIvl1iYLf67Nsx2awH+WhesIpe0xxKcslFqIAlD5g3QbtXeDFlaHDqMkbI5yG5AVouM6FJRa67fQD2eGbUqr04IZSPTNOg/lh1o4gJF/Ox1kxqF4wugtyJ4WUDW0sd6levirj0Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759025357; c=relaxed/simple;
	bh=uXHMtU44g8LdzdaHIpFjnIqp8AVQGjIFBiQtGjTrnt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hvfqQzWWvQmn2U1Q2RxbhINIq7RG5a7khPruRR+BX+aLuVpZcBYtYsy0sD0CbpOFUZm5xlOCXBBduaLPHz0UAV91FvrirZ1jiiO4Bwf8gvWxXxblTrxROa2zoKZjzY18ntK66/LbaciwYibXwbjgRimtt07TKr7u1eNf2k1KYdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=FZQFIzS5; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1759025344;
	bh=r/UU5OjQlNOk+0xgcmwYt26dsbPN+MROc0DRiB48QgY=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=FZQFIzS5wiSIvSZeZJoWSiAaClLiNu3ryCZHZXECPmPaQT4rMd2OyFWr++IgokcKt
	 gCbi6BfN5SRt+GJsnVde9TSizQ0SWyJN8PoFuSQ8Zu4AsdcfT620+pXCj7j8F7P2Ic
	 8WRBn0Nl0sO1ZlFqpYDo5OK83dI4IEUYMCLzfjLE=
X-QQ-mid: esmtpgz14t1759025340tfb5556f0
X-QQ-Originating-IP: OAcKHgODdTKKwX2NmUA8RS/mvctsKVecQ3y2vidb9Dk=
Received: from = ( [61.145.255.150])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 28 Sep 2025 10:08:59 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3441446003025408370
EX-QQ-RecipientCnt: 13
Date: Sun, 28 Sep 2025 10:08:58 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: Aurelien Jarno <aurelien@aurel32.net>, linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>, Sebastian Reichel <sre@kernel.org>,
	Yixun Lan <dlan@gentoo.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: "open list:SYSTEM RESET/SHUTDOWN DRIVERS" <linux-pm@vger.kernel.org>,
	"open list:RISC-V SPACEMIT SoC Support" <linux-riscv@lists.infradead.org>,
	"open list:RISC-V SPACEMIT SoC Support" <spacemit@lists.linux.dev>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>
Subject: Re: [PATCH 2/2] mfd: simple-mfd-i2c: add a reboot cell for the
 SpacemiT P1 chip
Message-ID: <E15EF3B2FD46EFE7+aNiYuset7FKRo_4C@kernel.org>
References: <20250927220824.1267318-1-aurelien@aurel32.net>
 <20250927220824.1267318-3-aurelien@aurel32.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250927220824.1267318-3-aurelien@aurel32.net>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: MpO6L0LObisWRFUV/rniBlOiGmHoOfXQcM4ziUkH3wvz1nGENeDTIesJ
	Z6ZvqRK7K17rcOQ17yD3kbwUDs4Ii/gGxkFXapktnGwjC8InF8bBDk0iu+QzkB6+hDAo+Ut
	0s1ynFSPUBkxeezPVZTgOB1SNOzT6Ej9c6D7IbUJxt7zGpMDo9JGgjEXkxlirQQB12bXCc7
	j5S6ohU70kKpM+WQP/0E7f/8mGFf8+0Vff5TiFr+vuU88BL8CAZzG0nJy6oDICCuE//6Z5T
	3Q/EU+lv74ygVKzA4Ao6Sx11leSAsEAmmLFFWiZhlPA5AYyEVEslwssQOAu1i1/5CuFanO+
	S5/GpIctxbWuSmaJvsJwhT/rDeo5LlgikVhtPhSVata0vJgJy5kJztm5Jv62I361oS2aAP8
	eFzkiJP5yNwbx/Ax+I5oN1n71o/TvZ66FpU5/umJTyYDWyNxzIvEKon3LUf7xgp1A3c8HzS
	1IOWiBpxF5mkQcWJQ3Va+fuLy1ChMYMSfc1CASDY1sllU1mkHIFHjYoAv3r8FApzsWmFrBY
	SE9F41te5Yhw+gHAMyO0O8PT/gpZjMdNRQMw7ZITPpuyUjj5iwIdSXxh/xr7l4pguAnJi+h
	NNZuCc5PcJHikXxqEea8TCN6RyCXb262/3IDkxQSy9LUexHRTuXMMNeob8Upda+ZHcRrFYs
	a+m+7OS2R3MVwI38ccQDIMlLbeZ/2TfdzJcW1Il4ylOKVBNTp/FErOUKOg7ADjIUAYchwAy
	1xDkjeGPSNb9R9wZy22SS5/62CrxpwaXH/W+wKW9tq9SZ6iKNkvIj2F9+T5Xcv+ItdviyO4
	i2Y9pBAzlo91AL87R+mPn9wuFKkBRqObXo3e6qIZuW0Bd4U3s8FjoT/NoocEpv/Fc3TyW/G
	x6CWIfepmxAoUm95rCe323Fv6pbzWftlwiMhMeuJ9wUz0qmE9Y6flwxfnO/jDFY6d5llHk/
	oSrgh/lqDXp0ncN8vfG73FdHIL9Bl2tqCJaHxNyAKE1F3n72Ap6ef6L03NQEy8MKr7X0SYK
	AGEuhVuTcrgjO9OkISjZG9kGXNGSQlDzhF5FUfasA8McqEwult48sBaX9ph2ArhLcgFIAcU
	Vh3cVSO/cL0Hnqgh5PaJf0=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

Hi Aurelien, Thanks for your patch!

On Sun, Sep 28, 2025 at 12:07:41AM +0200, Aurelien Jarno wrote:
> Add a "spacemit-p1-reboot" cell for the SpacemiT P1 chip.
> 
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> ---
>  drivers/mfd/simple-mfd-i2c.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/simple-mfd-i2c.c
> index 696b602051260..2e86efb0c82b8 100644
> --- a/drivers/mfd/simple-mfd-i2c.c
> +++ b/drivers/mfd/simple-mfd-i2c.c
> @@ -99,6 +99,7 @@ static const struct regmap_config spacemit_p1_regmap_config = {
>  };
>  
>  static const struct mfd_cell spacemit_p1_cells[] = {
> +	{ .name = "spacemit-p1-reboot", },
I’m not sure if this name is the best fit here.
Since the driver also implements reboot and power-off functionality,
would it make more sense to call it spacemit-p1-power?
I’ll leave it up to you.

Otherwise, LGTM.

Reviewed-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
>  	{ .name = "spacemit-p1-regulator", },
>  	{ .name = "spacemit-p1-rtc", },
>  };
> -- 
> 2.47.2
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


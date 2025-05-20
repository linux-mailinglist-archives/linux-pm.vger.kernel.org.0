Return-Path: <linux-pm+bounces-27429-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB4CABE2BE
	for <lists+linux-pm@lfdr.de>; Tue, 20 May 2025 20:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F3754C2887
	for <lists+linux-pm@lfdr.de>; Tue, 20 May 2025 18:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3466627A927;
	Tue, 20 May 2025 18:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="HMouFCEz"
X-Original-To: linux-pm@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC4B25C823
	for <linux-pm@vger.kernel.org>; Tue, 20 May 2025 18:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747766211; cv=none; b=D07muv989z8xEzsy7uFXjh+TWIuxBaLnH8wf/ftPF0L2fo3MVmUC8DsaZhOhK0DHyOPkXKB9PIeSjsRJSH7obDvPmXDEuvwyLLh/2Kjqi3+/jJ+NDZeEiCaHP3Tdxy0G8GKRFmnX4oOS/IJWAXRfpdwxwLJQaf+9qbV1ylrD9/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747766211; c=relaxed/simple;
	bh=t+cEEInYZzBR9YDi+caaNlT4O7lKe8Z3BgLcAk/EOik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q165JFHy47XGoY30QP0jbovxRpvUGYutb7oE+4iwd7vbzgcrs+IhKF1I6hW+fgws9dcVqqmgJYL+PPD70FVj89JXg7mKVuGPJmcV3OLQbM7nkAdZtb/3ZTvGRB8eQElvUizWyZjymwewrHYakNa9wShY5h4F3DEeQyizWfc8Bso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=HMouFCEz; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=dQZzSpw38okBWKsZXnPL9bfHWKnBcYjDpFLGg/aiMoo=; b=HMouFCEzqAfmrdwzBosxpq8Ob7
	kXuWO5h3ZwIfKoSWNU/C+KZtSD2ieMlvRN/nO5XwLfDR9XtZuo24ObGryH16edj7eAuzsY2M+mebl
	JKkhoZEbgQu+90bWRRfXEo42vPl7EQwgfXkSCKgPHF+EBQrMaaR3KPVMRZsB6r1bWXZynCul+//t6
	6B3nDgMsQM/jc12a9l2zWppqLmeNI9jnF9reWAeB5E08hqfISdglgB7BQDvaIGe0rGhdnFIznPY70
	kd+xLzQ6Tk2KrceUssdV0FgBIMVn5DpPX/X8PvSeScZxKHNQp6j9DKZ4BfUoIoJTKO1tZrcYKF7gO
	kWs20Rug==;
Received: from [61.8.146.112] (helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uHRpP-000495-Ib; Tue, 20 May 2025 20:36:39 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: ulf.hansson@linaro.org, mark.rutland@arm.com, lpieralisi@kernel.org,
 sudeep.holla@arm.com, Robin Murphy <robin.murphy@arm.com>
Cc: linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] firmware: smccc: Stub out get_conduit()
Date: Tue, 20 May 2025 20:36:38 +0200
Message-ID: <2195785.VLH7GnMWUR@phil>
In-Reply-To:
 <ab0476382e3342161beda94a45ddadb49b026dcd.1747760015.git.robin.murphy@arm.com>
References:
 <ab0476382e3342161beda94a45ddadb49b026dcd.1747760015.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Dienstag, 20. Mai 2025, 19:10:16 Mitteleurop=C3=A4ische Sommerzeit schri=
eb Robin Murphy:
> Various callers use arm_smccc_1_1_get_conduit() to guard their
> arm_smccc_smc() calls - since the latter is already stubbed out to
> support optional usage in !HAVE_ARM_SMCCC configs, do the equivalent
> for the former as well to make life easier.
>=20
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

Way nicer than to require arm32 rockchip platforms to
enable smcc stuff, even if not in use.

> ---
>  include/linux/arm-smccc.h | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
> index a3863da1510e..97dc4d47c664 100644
> --- a/include/linux/arm-smccc.h
> +++ b/include/linux/arm-smccc.h
> @@ -315,7 +315,14 @@ enum arm_smccc_conduit {
>   *
>   * When SMCCCv1.1 is not present, returns SMCCC_CONDUIT_NONE.
>   */
> +#ifdef CONFIG_HAVE_ARM_SMCCC_DISCOVERY
>  enum arm_smccc_conduit arm_smccc_1_1_get_conduit(void);
> +#else
> +static inline enum arm_smccc_conduit arm_smccc_1_1_get_conduit(void)
> +{
> +	return SMCCC_CONDUIT_NONE;
> +}
> +#endif
> =20
>  /**
>   * arm_smccc_get_version()
>=20






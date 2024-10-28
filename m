Return-Path: <linux-pm+bounces-16610-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 114D69B3855
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 18:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA028281B6B
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 17:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE061DF246;
	Mon, 28 Oct 2024 17:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q2K5myif"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D2B188917;
	Mon, 28 Oct 2024 17:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730138204; cv=none; b=SRDFYPHNG7h6l2yF3S97SN9X+qIAeKwB7OSO/rd7gT3kHQK3W+Iv8g6m2F68+dAe2SsIGKJb2sY3ZTpAuGx103CA9kOTKk0sAGN95+Mnr3aKMvS9J60lxrYEghFXkIcvl/RGBla0MifwXSNIFHnyMtoKM5Zn4xC+NbZW4RYa2Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730138204; c=relaxed/simple;
	bh=ZcIOdBBX9x9S4mccfN00QP50E2GrhzZTTHwWiGiLi9c=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=rTaWdxH0+b2Zd5PYe52F4vO6+0qaaDEbPXTXMGyGhwDBVc3x2N62lgAV0mxSC53pngNiNn8nZNmox8hdVRNWTLT4VFZj/kJkUveqdZqLvLsnBHA83mjRt5Oc5kU2v0fOUGA/0Zgik6bOeV7Ni3l3FKHUvcsEsnlyfQZ6zfgp4bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q2K5myif; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C67D5C4CEC3;
	Mon, 28 Oct 2024 17:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730138203;
	bh=ZcIOdBBX9x9S4mccfN00QP50E2GrhzZTTHwWiGiLi9c=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=q2K5myifszZpveps8gx27XMOnT2U1YZffqsvHUS5IFNf4nEQ7fRd9bHS1XjPRGVZO
	 KFpTeeiqdejQAS/xZlcl433menOvBPr9pnIFEj5feTysVsO64XStek2hnsNwIHh+Ws
	 g/0BbGIYHDdgr9GyB2KBNCC6C/Q99N+Fz+jFO9fQzcbex+4mxmpu5jfAEZGwIFY44v
	 TuHM+TectHEqKNEATQM52fCJlsskYy3rDPV8nA56mWPnjJvTcstWitzpoZ0C3ATKJN
	 MYmeseQDth9uFQCH9gItWXXXZX4uItoxQTrrKg2RFrW3WbqEmicuQUDtU0+D6FzmpJ
	 y3qBqUCtB9ofQ==
Message-ID: <bb5d855954d5ff8694a3978a9f87a9d2.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241028163403.522001-1-eugen.hristev@linaro.org>
References: <20241028163403.522001-1-eugen.hristev@linaro.org>
Subject: Re: [PATCH v2] soc: qcom: Rework BCM_TCS_CMD macro
From: Stephen Boyd <sboyd@kernel.org>
Cc: andersson@kernel.org, konradybcio@kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, djakov@kernel.org, mturquette@baylibre.com, Eugen Hristev <eugen.hristev@linaro.org>
To: Eugen Hristev <eugen.hristev@linaro.org>, linux-arm-msm@vger.kernel.org
Date: Mon, 28 Oct 2024 10:56:41 -0700
User-Agent: alot/0.10

Quoting Eugen Hristev (2024-10-28 09:34:03)
> diff --git a/include/soc/qcom/tcs.h b/include/soc/qcom/tcs.h
> index 3acca067c72b..152947a922c0 100644
> --- a/include/soc/qcom/tcs.h
> +++ b/include/soc/qcom/tcs.h
> @@ -60,22 +63,19 @@ struct tcs_request {
>         struct tcs_cmd *cmds;
>  };
> =20
> -#define BCM_TCS_CMD_COMMIT_SHFT                30
> -#define BCM_TCS_CMD_COMMIT_MASK                0x40000000
> -#define BCM_TCS_CMD_VALID_SHFT         29
> -#define BCM_TCS_CMD_VALID_MASK         0x20000000
> -#define BCM_TCS_CMD_VOTE_X_SHFT                14
> -#define BCM_TCS_CMD_VOTE_MASK          0x3fff
> -#define BCM_TCS_CMD_VOTE_Y_SHFT                0
> -#define BCM_TCS_CMD_VOTE_Y_MASK                0xfffc000
> +#define BCM_TCS_CMD_COMMIT_MASK                BIT(30)
> +#define BCM_TCS_CMD_VALID_MASK         BIT(29)
> +#define BCM_TCS_CMD_VOTE_MASK          GENMASK(13, 0)
> +#define BCM_TCS_CMD_VOTE_Y_MASK                GENMASK(13, 0)
> +#define BCM_TCS_CMD_VOTE_X_MASK                GENMASK(27, 14)
> =20
>  /* Construct a Bus Clock Manager (BCM) specific TCS command */
>  #define BCM_TCS_CMD(commit, valid, vote_x, vote_y)             \
> -       (((commit) << BCM_TCS_CMD_COMMIT_SHFT) |                \
> -       ((valid) << BCM_TCS_CMD_VALID_SHFT) |                   \
> -       ((cpu_to_le32(vote_x) &                                 \
> -       BCM_TCS_CMD_VOTE_MASK) << BCM_TCS_CMD_VOTE_X_SHFT) |    \
> -       ((cpu_to_le32(vote_y) &                                 \
> -       BCM_TCS_CMD_VOTE_MASK) << BCM_TCS_CMD_VOTE_Y_SHFT))
> +       (le32_encode_bits(commit, BCM_TCS_CMD_COMMIT_MASK) |    \
> +       le32_encode_bits(valid, BCM_TCS_CMD_VALID_MASK) |       \
> +       le32_encode_bits(vote_x,        \
> +                       BCM_TCS_CMD_VOTE_X_MASK) |              \
> +       le32_encode_bits(vote_y,        \
> +                       BCM_TCS_CMD_VOTE_Y_MASK))

Why is cpu_to_le32() inside BCM_TCS_CMD at all? Is struct tcs_cmd::data
supposed to be marked as __le32?

Can the whole u32 be constructed and turned into an __le32 after setting
all the bit fields instead of using le32_encode_bits() multiple times?


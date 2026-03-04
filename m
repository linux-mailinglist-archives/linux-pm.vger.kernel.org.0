Return-Path: <linux-pm+bounces-43576-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6F26HcEWqGlTnwAAu9opvQ
	(envelope-from <linux-pm+bounces-43576-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 12:25:53 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A9E1FEF36
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 12:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 801FF3001FC4
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2026 11:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C358E3ACEE7;
	Wed,  4 Mar 2026 11:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F22L43OS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735C23A875E
	for <linux-pm@vger.kernel.org>; Wed,  4 Mar 2026 11:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772623549; cv=pass; b=Aa9f/UcLcIs+CRdA4gX3RX38nK6Ms+SA3ltgsPt95t9dOQx4bbqAYu6TRhtCPrXQ7OMNreOXqZPiEXHd9wqjPZW62ppfD2Yg9zHHefgbUycakgzW9xu/WSmb5aqjSDGoaAA1NfGurZ1KGsdn4P25AGWDglLjGvSeofrxkb9+i2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772623549; c=relaxed/simple;
	bh=oa4vWPoB1fF5ftQFI6lDu1BMB8/GYQYIVMLv015Aa1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f4Iht+2PwPorDYzJac2Yr+qG4ioNHj+218jzR8OxzFMyQRJlsD+su1mGsK4HtcXY3cyVCRt5qmuv3cFHlmoUvW2XYXoVW3b5KAKZfepKzkeiXb669WOmFfOHKOtS6M3Z7UjdLu4WHsZrYz7+2SsGso5Kp/RB6JQtbZKFRxUbEzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F22L43OS; arc=pass smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-38a283adc3aso15251701fa.3
        for <linux-pm@vger.kernel.org>; Wed, 04 Mar 2026 03:25:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772623547; cv=none;
        d=google.com; s=arc-20240605;
        b=NU2GSgo801EwhElzYQwux0i3pBiyR1NbNZzcBMnUCRXzNK9/f1JbK/VuerJ5ECUWh7
         hiVvR50lZ270ChOcZRFcrJb8uuygTvDP5ID9mtCHYaRKdcGYPbUTuP0NRfA4hjP3yWzV
         GUKwYkgKquAILDYdlx5vJB9UoRDIPYLdv1S3fx+vXeU3N6hnW01vHDtq1LNxqNTgzkPg
         qyNyTKdS95ayoQouy3AVmhWaZIp0sm7Pgm8/KxZ0iLVfUV2B+ywaIyMHtxCf4WIfG701
         JhL0M0CDBqQ4hsxsnu3Hg2i1ueb20fpuXftbYKiZPd7osfsueO3+46bsqSuAJ5XPmnwS
         VgTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ZFU75WKoCSxMgaLIkMh5UQtNA2gCsSWtdMfcToA7Tlc=;
        fh=xn4JRRikfZDLOcgMsER5WtHjxBMBQzgsUYlufJ/upSM=;
        b=id2G8c0Xu+hq8eeWTvl+V2lTMaA1HOrmgnY1UtCK6Uy3NQj2GmpzlFHpVVaX65oqNF
         z1vr93gXphSwxK6rlepLAW3eq5TLjAXZFGVp4BQmT5foL71aoaVwQxwNvz9gY4RomJwO
         zJEVrC6+eM+a6g8JtKXkUOabPTyBZYmb7XNKKbRd8T8tWfsCxHTQ7qWGHq5biW8xJZ+g
         mFNPewGn/3OSvuEPRSw9A+AKWfFdgp94NhiBuNg348avACeBkugS5FixUPTbZ2Rmo48h
         aPEdyPbw6L3vN+OG/ulul0bjJvR89Vj37fSX+Ov1IUuzNNYn6fPrTx4a7bl9UjY/RVoM
         Zrvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772623547; x=1773228347; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZFU75WKoCSxMgaLIkMh5UQtNA2gCsSWtdMfcToA7Tlc=;
        b=F22L43OSR8lrj1aIoE2NKQfTAo2CkYa2snPyJkN9QtOVYwfzuDVf/c6ErwnBonRpJ6
         tv3f83DYzCVl75CQqTumRxeElsg70QTpm7nNNBpQO3wltAf3bQOANK6uxLhjg3aOFaSD
         edG7ELKzyo/NJkOeufkb8zjlcyhxqz/DrS3xUWs8z8UuPB9P07YDYJyNdVXD2tGhna+h
         e7XV+6U0KsLMJrkRsWvnGYjkqAfRv/HuVf3JEX3hzyD4AANMJRJsFaTlBLfFqmVFs77H
         8ON1/RkRmyIp6JU/pIgyNRsITfcCjtEyoz78EFz50J2rY7njf8v64U09k9DVjjsx8+vz
         vXQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772623547; x=1773228347;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZFU75WKoCSxMgaLIkMh5UQtNA2gCsSWtdMfcToA7Tlc=;
        b=olV3CQsDTg2/i641prWAUAaJWIkLY1Z/eT+MQ+41R7hrLFyhcZSHxF+06MyeZsT/hu
         Ij4E9ddbAPONNdxQ6Hbczoakruf6cT4HW1YHuJXQ8WeWVruM9fnIH8oqzz/z69z5jY6a
         LI/pDQAzKtP4zjJRKrj6gIF7IVu6ADo3KbnYw+Vv6H7D4nC04Ta5/reWZxkWMhoqZgvK
         UvDIdlqZHUnMMAt0YyuORkS1aezCl100PDTCSZZVZWJ6DvFPxOYO9nib6LbD+8ja51m1
         SEzjY9a6z9FAXhb+I3Dbm3wSOohlMpLDmJfavnQ8FZ2kSIoUs2OLwFM9WG/iDH6+lVjg
         QqAA==
X-Forwarded-Encrypted: i=1; AJvYcCVN4z0OxG3CviptznBIipvXrWfBQxiuusyujf1n48xd4kN5rOUEwyJtvlHRHbPZH75bKj1IH395DA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzuTWWryCZUnScMFVJ4n6gVvhyJwYLdyl0rMHiF8dek89jw0Yub
	exZaVvLRcHnTN5QjWwi80PUkVeYiXuYC3OP7s5zN/U7cGhMFmHCBVnTcvN8SAcF/qR5TOR6VVkU
	1droxyPFKdrGGXO5zSEhMSN+P0q7QKQRdUnhJ8lO5eg==
X-Gm-Gg: ATEYQzyJmui2orOq865l+EyC2k7udPIw/qOheksklaDJGJBtSE7DonflNgEjtMnxqTf
	pSE4yrcyFxMU3rHOYusa2xjHV7Z1RKPEIizWTxHkgmSChTA4wwpob0jty4+7GL8mHSpCdyF+mcG
	QP79UxSjJtgRvj23R+nRtwzKQH0Y42qMr+Q/ugjkFyEMQ1D2rxN9JU5+0WOoOgvC6PpntVDrRij
	8sGFM3WfWSoq1Th3DCur+EP/RaOlbD/e+tUydGiy/fdQPgqryosBR2K/MM3ygVYXUYhBFbSDcwO
	Hop9OMSZVRsBpo1r3x4=
X-Received: by 2002:a05:651c:e18:b0:383:282b:7ac5 with SMTP id
 38308e7fff4ca-38a2c7bb1f9mr15449121fa.25.1772623546573; Wed, 04 Mar 2026
 03:25:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302-eliza-pmdomain-v4-0-e61ae2bac805@oss.qualcomm.com>
In-Reply-To: <20260302-eliza-pmdomain-v4-0-e61ae2bac805@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 4 Mar 2026 12:25:10 +0100
X-Gm-Features: AaiRm53skmRHI-RjvqHgia1Wivc8zYgqP69t0Gy83VzMqYB1anaikfyRhx3Cq5w
Message-ID: <CAPDyKFrvMieutLjHkL_dvfm6X9OpLsuGn_SPp1-FeBO5oe-zhg@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] pmdomain: qcom: Add support for Eliza SoC
To: Abel Vesa <abel.vesa@oss.qualcomm.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
	Taniya Das <taniya.das@oss.qualcomm.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 22A9E1FEF36
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43576-lists,linux-pm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ulf.hansson@linaro.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,qualcomm.com:email,linaro.org:dkim,msgid.link:url,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Mon, 2 Mar 2026 at 14:29, Abel Vesa <abel.vesa@oss.qualcomm.com> wrote:
>
> Document the SoC specific compatible in the devicetree bindings
> and add the driver support for this SoC.
>
> Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> ---
> Changes in v4:
> - Dropped the GMXC and NXP2, as suggested by Kornad.
> - Link to v3: https://patch.msgid.link/20260224-eliza-pmdomain-v3-0-6e13d3aa70a1@oss.qualcomm.com
>
> Changes in v3:
> - Picked up Dmitry's R-b tag for the driver patch.
> - Re-worded the commit messages with better explanations.
> - Dropped the MMCX and MXC entries as they are not described
>   in downstream and not used. Consensus reached off-list.
> - Link to v2: https://patch.msgid.link/20260223-eliza-pmdomain-v2-0-23fb87eb70ef@oss.qualcomm.com
>
> Changes in v2:
> - Changed the MMCX and MMCX_AO to the PDs with CX parent.
> - Picked up Krzysztof's R-b tag for the bindings.
> - Picked up Konrad's and Taniya's R-b tags for the driver patch.
> - Link to v1: https://patch.msgid.link/20260216-eliza-pmdomain-v1-0-c51260a47d6d@oss.qualcomm.com
>
> ---
> Abel Vesa (2):
>       dt-bindings: power: qcom,rpmpd: document the Eliza RPMh Power Domains
>       pmdomain: qcom: rpmhpd: Add Eliza RPMh Power Domains
>
>  .../devicetree/bindings/power/qcom,rpmpd.yaml        |  1 +
>  drivers/pmdomain/qcom/rpmhpd.c                       | 20 ++++++++++++++++++++
>  2 files changed, 21 insertions(+)
> ---
> base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
> change-id: 20260216-eliza-pmdomain-dd10911bd4e4
>
> Best regards,
> --
> Abel Vesa <abel.vesa@oss.qualcomm.com>
>

Applied for next, thanks! Note, the DT patch is available on the
immutable dt branch too.

BTW, in regards to the immutable dt branch, is that something that you
guys are using or should we consider to drop it?

Kind regards
Uffe


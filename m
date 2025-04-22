Return-Path: <linux-pm+bounces-25898-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 971B4A96C99
	for <lists+linux-pm@lfdr.de>; Tue, 22 Apr 2025 15:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 929BF17CBBF
	for <lists+linux-pm@lfdr.de>; Tue, 22 Apr 2025 13:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7F628C5A6;
	Tue, 22 Apr 2025 13:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AqUAcc/9"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F109728BAB1;
	Tue, 22 Apr 2025 13:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745328269; cv=none; b=SYrOF0UZIPqigQKUMERpvQcbxpBTbXveEfBj+BbuFJ2dO9mKNgyqtLOwSwzICk0Zso562hDm3Svltrky5tlAuMRzc5lyhaMg400+HcTSXpQ7PgINJCSEPl3f+vvmFwQ71Z9jlJpxgcaDfKZymd0/1N5xRbTQHxxxqcMBHhII3sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745328269; c=relaxed/simple;
	bh=/h7PI2xPhfynLVO4zoub6NIw4SpmCt9camqlOU3G6fE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b8mHy9VkbzgvnMidEoEp7yRBJXRWyVv+WLUzp9NSnuytNMlfsqaZjR+x73akKYFtGsXVJJ2RQbJVl3NLArk7W7S/c2JKPYg72qxAF48HebLH0pSkqYK3Jn3RBfyq9ZQopqjqskv0h8ySk81qC09oUZw7YlkjQ/5Zg/bdDMSHxqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AqUAcc/9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D766C4CEEA;
	Tue, 22 Apr 2025 13:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745328268;
	bh=/h7PI2xPhfynLVO4zoub6NIw4SpmCt9camqlOU3G6fE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AqUAcc/9cwblA5PVjr87WWUhOw3ptGwBSV7i6pvthkXKFjX14Dtbpme9NA623xje8
	 uV6nXWSKLRWIG03oDXKhGBlKbg0JnvHstmriMGcmZRoRZshrQPv6N0LDt+MpZgTC7H
	 Zi/iR2fP8IF6vmZeRz0PKchY5BniMesfb2gPvuD9LDXmusmHK6fqKNdhHjo81Vh5Jb
	 GQDu1/0rt23kU6YyuO7TAEQEtAK2tuzpdd22tSpAdM7xRwlkCobUO6WXY57X/w7dR6
	 SebTLshwb26ltKqAO7jxb4WkDmogWEl3lN51rMPrYztcuNAQ5Lz42PlHrhezEfC7tx
	 ceNIEfx/QEMUg==
Date: Tue, 22 Apr 2025 08:24:26 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Ajit Pandey <quic_ajipan@quicinc.com>
Cc: Conor Dooley <conor+dt@kernel.org>,
	Jagadeesh Kona <quic_jkona@quicinc.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Imran Shaik <quic_imrashai@quicinc.com>,
	Taniya Das <quic_tdas@quicinc.com>, linux-arm-msm@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: power: qcom,rpmpd: Add SM4450 compatible
Message-ID: <174532826620.1091984.4459755072036932002.robh@kernel.org>
References: <20250417-sm4450_rpmhpd-v1-0-361846750d3a@quicinc.com>
 <20250417-sm4450_rpmhpd-v1-1-361846750d3a@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417-sm4450_rpmhpd-v1-1-361846750d3a@quicinc.com>


On Thu, 17 Apr 2025 22:37:39 +0530, Ajit Pandey wrote:
> Document compatible for RPMh power domain controller on SM4450 Platform.
> 
> Signed-off-by: Ajit Pandey <quic_ajipan@quicinc.com>
> ---
>  Documentation/devicetree/bindings/power/qcom,rpmpd.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>



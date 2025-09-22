Return-Path: <linux-pm+bounces-35190-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1C8B93380
	for <lists+linux-pm@lfdr.de>; Mon, 22 Sep 2025 22:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40EE2190567C
	for <lists+linux-pm@lfdr.de>; Mon, 22 Sep 2025 20:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F772302748;
	Mon, 22 Sep 2025 20:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="saAgGjL1"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF9B22259A;
	Mon, 22 Sep 2025 20:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758572774; cv=none; b=a/9NwigonR2Xn2eLvWBlFBoUtwDsInJREBV9EPHRVlP4u25LWsk+YEpptzSFjjCBqoea3TRERHq43CrK2FVJY4MREbwODGX8xxPVggjSu0kHQNFEhQzZND1eJxsIfdovJdRNFz0nqJ/VBMEDJzOt/A3+U98Ou50U323TpZytD9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758572774; c=relaxed/simple;
	bh=l5lnmbDzd10qt/bOUXemT2muAwVjbvmYxpxePXIG/y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7qsANgxHWgt37c57l6Wy/XthTbOIcljfw/sbTu1KL167pd8BjF6FTIWfqQLy5b7nYZaucqeH4GUqiUYuq8iBOu5rO9mY1CfTmRt3qX/Ayot6kVAM65HXyV7xYPKeiScl0U/wFfy6RqdXxcC6sr2wap4RHp4J1b4FPUmBQXuS6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=saAgGjL1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A142CC4CEF0;
	Mon, 22 Sep 2025 20:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758572771;
	bh=l5lnmbDzd10qt/bOUXemT2muAwVjbvmYxpxePXIG/y4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=saAgGjL13iZm1qcJcb/cj77P8NH8hjc0uH72qEdQKdLozaOe9dqDyz/mHOC5eVeDs
	 FCL/XBAXI43HjnrPQb3yaW9VXjep67fpNnIuF8fH8DdhaPvHQMD5jpHhg7eDASzwhN
	 /SgW2TSvjnFVn9GEfYfpV4oGO5zDJIHjEp1z4MQqZs7Vz8/+gTZXyz1ApCK6jqEWr6
	 ZKZTKdAxTYuMfbv+NWdVxKuj+tOS6abMc3fO8Zu+c4jSSj3mr6hKKjeAiaedjbYAyN
	 9KsiWmJ1uYMNWzLe3GXsV+Vwzx3ENVhyhJpUnrYyQbkBMF5MWKWUaqOLLfQ9PhZvHA
	 dE6T8VdGb3lEw==
Date: Mon, 22 Sep 2025 15:26:10 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	lukasz.luba@arm.com, daniel.lezcano@linaro.org, amitk@kernel.org,
	linux-arm-msm@vger.kernel.org, rafael@kernel.org,
	conor+dt@kernel.org, rui.zhang@intel.com, krzk+dt@kernel.org,
	thara.gopinath@gmail.com, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: thermal: qcom-tsens: Document the Glymur
 temperature Sensor
Message-ID: <175857277024.1274056.7585926568505615723.robh@kernel.org>
References: <20250920123631.281153-1-pankaj.patil@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250920123631.281153-1-pankaj.patil@oss.qualcomm.com>


On Sat, 20 Sep 2025 18:06:31 +0530, Pankaj Patil wrote:
> From: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
> 
> Document the Temperature Sensor (TSENS) on Glymur Platform.
> 
> Signed-off-by: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
> ---
> Changes in v2:
> Fixed to sort entry in alphabetical order.
> 
>  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>



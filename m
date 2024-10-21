Return-Path: <linux-pm+bounces-16060-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E366C9A5DDE
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 10:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F7C1B2193F
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 08:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745FD1E1317;
	Mon, 21 Oct 2024 08:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCmJy0gy"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCEB1E103F;
	Mon, 21 Oct 2024 08:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729497676; cv=none; b=R74P0Iwg2vU2XHkx7Zjop+8tTvrCWVrYhANDakGy2NZ76Hpkp1pRpG15TQhmeosIXKNXbzcbAw8GjWq8YZWnNKhOwCy63VKhSNtGFbz1PSGTIMk3PbOG2kPWAMfs+txkV7AhczzHScKIW/RxiQhGyRBdziTE+XhwF5FIC9Iw+vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729497676; c=relaxed/simple;
	bh=xLOJeCy3sPh7+7x4KNuj2LalADN9iHcB5csJaoSXAVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TfmNLlXFUMkQKCxocln2OQD6rYaA1Ag2HK60ZGWN5E1zw6K0i5LX4XsYfV/75I0vL1oFUOQaypilacCXCy7j0mEm/9L+1OduRl3HrUzc9Mh5MwOTr+EUhW2zn1mA6Jibhh1hWVgZCzadUCffOHs/wLSpcpGJNQy+o04WXBefvJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCmJy0gy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16BF5C4CEF7;
	Mon, 21 Oct 2024 08:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729497675;
	bh=xLOJeCy3sPh7+7x4KNuj2LalADN9iHcB5csJaoSXAVE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SCmJy0gyFzfs5aAvu+AE4a05nL5b4eJs+XGnChyJCd8YoT1Qk6GyJgk4Fy2xdeQ8T
	 HtHdOHvgLn78uPp7PfnkUA+dT2EHq6jVox1KiWHjjXtAqECZ4zRXnUpF8utZWrEZuq
	 ypCY8KbPLac8ZDkucT806jSwm/3vUZicDGN/pbGOE5Gz4uOMiBxMjD7JKHUX7Ax5oC
	 r10Otlr0Doc6bVL5aOkw7XcJdc8w6cV1jwT2x4OUqfPSJPVXuQBaK1YR8iDgX9/hQb
	 SVyFneEhkxa7doUswycrWapb7hGEl/bQenlf6ntZ9b7Eb22k6RgGtAWNNJ0xOlyurx
	 6E/ab3H7eOKUA==
Date: Mon, 21 Oct 2024 10:01:12 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: cpufreq: cpufreq-qcom-hw: Add SAR2130P
 compatible
Message-ID: <frzcfsa5bbavv4qr4oermqmvaon647z77dh327m6whdq5e2pxr@wd77fo45c43i>
References: <20241018-sar2130p-cpufreq-v1-1-822e00b9a663@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241018-sar2130p-cpufreq-v1-1-822e00b9a663@linaro.org>

On Fri, Oct 18, 2024 at 07:41:23PM +0300, Dmitry Baryshkov wrote:
> Document compatible for cpufreq hardware on Qualcomm SAR2130P platform.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof



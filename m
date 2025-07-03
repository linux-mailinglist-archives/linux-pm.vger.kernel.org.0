Return-Path: <linux-pm+bounces-30008-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39620AF6B5D
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 09:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E890524CD9
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 07:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1EBE28DB6C;
	Thu,  3 Jul 2025 07:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jxub18IX"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33282F32;
	Thu,  3 Jul 2025 07:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751527299; cv=none; b=q7Lpw5RTdd9QxWx7mmT4Y/wnL3ANyLccwLQf7RI63qTYF+n5qDwxceGz/GkJ298cm6TDh6ZE7tiYoIEUAOJSQXHZlqDedvbQeaz7+Cs0vCJZHCnIxaJg86bLpHU58OEsQlijLrUiNNjCYOUVR3BAmRLoRRVFtMnQ/qfd9V7Dekc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751527299; c=relaxed/simple;
	bh=lYiH77CF4bNApHrVuAz1KjuhDxqZDyfAjW2O45T2jP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sNKKpUwJJ3ih4TvqtwYOfyTb9Uu15mHNfDYbI8OzgnrbDE3PjvDlCoi729Tm7Zvqi+hclKbV63iwBfFWHmH35H+NipW74A2IayRS6JQFZo6U5yEDU/eCM8s+T3YRQGN2M1BkJUf/cGunDStEjFHjHMEPjtPVYId2N7LyKwad6eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jxub18IX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF6D9C4CEF1;
	Thu,  3 Jul 2025 07:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751527299;
	bh=lYiH77CF4bNApHrVuAz1KjuhDxqZDyfAjW2O45T2jP8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jxub18IXjqIfX+VN/bqirTuCIzI0yBZaVg5UAJ4J7yNHSsK5T6emYIPDNjHDYEWhu
	 wFODrKAbKjHitd6Ax7rt1lUSP1DSAKA4PvOKUogQDKbWVbI5iDBo5Yd2RatNERoA85
	 X2E7oEuavV42AjfjnswRG7JMXJ/lGGYBjLaEWG2qOX7BMcVz6jOxpA1zfqEOX1m9/E
	 lA2+agTV9TfBCGRoKB+wkrQxabvRSlz8TofUtWuLgERZyC7dMl18+FIc12dKdSwzhn
	 CuDfbVVWUEnM5WEz2Lq+nf72tjtzzATyqBW93hTJCukGu567/ovp4UL4tsluK1JFAN
	 ej0Jmue2KpQOA==
Date: Thu, 3 Jul 2025 09:21:36 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Taniya Das <quic_tdas@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Ajit Pandey <quic_ajipan@quicinc.com>, 
	Imran Shaik <quic_imrashai@quicinc.com>, Jagadeesh Kona <quic_jkona@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v5 0/3] Add support for clock controllers and CPU scaling
 for QCS615
Message-ID: <20250703-daft-asparagus-gaur-e77861@krzk-bin>
References: <20250702-qcs615-mm-cpu-dt-v4-v5-0-df24896cbb26@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250702-qcs615-mm-cpu-dt-v4-v5-0-df24896cbb26@quicinc.com>

On Wed, Jul 02, 2025 at 02:43:08PM +0530, Taniya Das wrote:
> Add the video, camera, display and gpu clock controller nodes and the
> cpufreq-hw node to support cpu scaling.
> 
> Clock Dependency:
> https://lore.kernel.org/all/20250702-qcs615-mm-v10-clock-controllers-v11-0-9c216e1615ab@quicinc.com
> 
> Changes in v5:
> - Update the documentation for CPUFREQ-HW for QCS615.

What did you update? This has to be specific, not vague.

Best regards,
Krzysztof



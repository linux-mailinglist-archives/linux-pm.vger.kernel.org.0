Return-Path: <linux-pm+bounces-17016-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D54C79BC844
	for <lists+linux-pm@lfdr.de>; Tue,  5 Nov 2024 09:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95AE2283839
	for <lists+linux-pm@lfdr.de>; Tue,  5 Nov 2024 08:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03691CFEC2;
	Tue,  5 Nov 2024 08:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i7aOWr+L"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15851CEEB9;
	Tue,  5 Nov 2024 08:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730796307; cv=none; b=dIhjxze2eA9WXWEBJIBtur9vYm2ARL9WHO4Ip5fE7lHfdFmeytFDFc4ZVdY9lwfIq5jssNjPsvza2hMMoTv2mLDd+vdVLZoVbfSctQ9e5AxBSJMnvhXth3zkV687kKcZWXT6eUbJHGFJ5cny1w7IeRBQQ0/U3l3PMI4XMqUsWoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730796307; c=relaxed/simple;
	bh=nBMLl/XA/qJ8pnqaOhyCBG2cviGgA9KlIF+RG6N9b/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g6hLH9FavqCnXJb3/RR/PRT87OjGQ+RomKJELfSjyLvCttcUAH0DHIIEpYwgo1LXcyXwoyuGVz+qKHh1+i+nAJTFSyQ5Q1dNA/0OLLONlpEu2QsxsSYI4jv/ZfvQS2iFc73BlntkBrzwGRwCPx6R3LSZoAHP6JnBu7JYltEyjyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i7aOWr+L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72D32C4CECF;
	Tue,  5 Nov 2024 08:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730796307;
	bh=nBMLl/XA/qJ8pnqaOhyCBG2cviGgA9KlIF+RG6N9b/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i7aOWr+L7zoCBNUuB99rz3M1KB6mhzNOBfjw6o4WZoMor1gl5pZaUFwlLZXyz/tIz
	 QNSCCKu1jLLqx8q7Hn4wk6soAakrfjYc3yZ+VeNmj/acrcuRJGyMfQWVPiFXG0W0OZ
	 EuxbiGoDGbX/9oo1lJgwCZgn2zJ0Bm6e077MGgHvUscvWpqn9mviX0XkBfFew8hxPT
	 B1UH9vst0VEsABLmO8RCkNDxp42j1dFnoWKwWhjcj7WWwmEL8g89Inkn1jb+H5Ilir
	 kgWee/RofkHnsqx+2sQDfmX2JnXM2bE/2/QY+1jWJJRb+Ofmnff6GOdEj2zCSJlOjH
	 PhmfZfVkDPcDA==
Date: Tue, 5 Nov 2024 09:45:03 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
Cc: srinivas.kandagatla@linaro.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org, 
	daniel.lezcano@linaro.org, rui.zhang@intel.com, lukasz.luba@arm.com, andersson@kernel.org, 
	konradybcio@kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, quic_srichara@quicinc.com, 
	quic_varada@quicinc.com
Subject: Re: [PATCH v6 1/7] dt-bindings: thermal: tsens: Add ipq5332, ipq5424
 compatible
Message-ID: <mi2sts34gdjpvimf2q3yoxh32wggwckjjfqwzaaj2umhibfpox@t754qqkzvb4v>
References: <20241104124413.2012794-1-quic_mmanikan@quicinc.com>
 <20241104124413.2012794-2-quic_mmanikan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241104124413.2012794-2-quic_mmanikan@quicinc.com>

On Mon, Nov 04, 2024 at 06:14:07PM +0530, Manikanta Mylavarapu wrote:
> From: Praveenkumar I <quic_ipkumar@quicinc.com>
> 
> The IPQ5332 and IPQ5424 use TSENS v2.3.3 IP with combined interrupt.
> RPM is not available in these SoCs, hence adding new compatible
> to have the sensor enablement and calibration function. Also add
> nvmem-cell-names.
> 
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
> ---
> Changes in V6:
> 	- Remove the R-b tag because support for IPQ5424 has been added
> 

I wish we rather finish with this patchset and add ipq5424 later, so we
won't have to re-review.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof



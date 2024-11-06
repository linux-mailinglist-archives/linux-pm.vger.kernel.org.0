Return-Path: <linux-pm+bounces-17049-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D196D9BDF22
	for <lists+linux-pm@lfdr.de>; Wed,  6 Nov 2024 08:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F0531C2092B
	for <lists+linux-pm@lfdr.de>; Wed,  6 Nov 2024 07:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AC8A2D;
	Wed,  6 Nov 2024 07:07:37 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0698B192B61;
	Wed,  6 Nov 2024 07:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730876857; cv=none; b=KUGCBl7kKUrhi4xrNOmvHH1xTOd+2YwoiQ4XSSCIaIXNhV2IfQuXBj/mezM18Hrrn1HRTzZqpLcFkIaTRsQER3x/njj/1Z+Evz88DT/JmJcuVQsAnx7iJ9dgF13Ysqwsyq9LL4ANEwKFMq7ahEsOljRCaictu23B+oTH9tLBlJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730876857; c=relaxed/simple;
	bh=5gX+qOBsnoRF32QXVBMQVOvAsbBS41144YvmmdrkYxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SzysHqxUoRwFhQq7gURS+0xwXO3BlmpIFC8yuT5EtwJ/jZLIN/2KWYIqBW/HdE4AN+0dpBt/D+xIBwCv/VuXd92ONJQFzWrT9kfpT+QI12N3LkAi5rfh7v2x4AKewvj3J03ea2dzfJSoTOHCzqiIGrd0d5FQq+LAdHubMW5DxRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4EA91063;
	Tue,  5 Nov 2024 23:07:56 -0800 (PST)
Received: from bogus (unknown [10.57.64.60])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C05C3F66E;
	Tue,  5 Nov 2024 23:07:17 -0800 (PST)
Date: Wed, 6 Nov 2024 07:07:04 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: cristian.marussi@arm.com, johan@kernel.org, ulf.hansson@linaro.org,
	jassisinghbrar@gmail.com, dmitry.baryshkov@linaro.org,
	linux-kernel@vger.kernel.org, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	konradybcio@kernel.org, linux-pm@vger.kernel.org,
	tstrudel@google.com, rafael@kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH V5 3/6] firmware: arm_scmi: Report duplicate opps as
 firmware bugs
Message-ID: <20241106070704.xqycfwhyrkui426w@bogus>
References: <20241030125512.2884761-1-quic_sibis@quicinc.com>
 <20241030125512.2884761-4-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030125512.2884761-4-quic_sibis@quicinc.com>

On Wed, Oct 30, 2024 at 06:25:09PM +0530, Sibi Sankar wrote:
> Duplicate opps reported by buggy SCP firmware currently show up
> as warnings even though the only functional impact is that the
> level/index remain inaccessible. Make it less scary for the end
> user by using dev_info instead, along with FW_BUG tag.
> 
> Suggested-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep


Return-Path: <linux-pm+bounces-14372-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 330E897B0F4
	for <lists+linux-pm@lfdr.de>; Tue, 17 Sep 2024 15:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8B4D285C99
	for <lists+linux-pm@lfdr.de>; Tue, 17 Sep 2024 13:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944C417107F;
	Tue, 17 Sep 2024 13:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qFDmLgW+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C21166F25;
	Tue, 17 Sep 2024 13:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726580886; cv=none; b=VSw/PSnLD1kXOosW4nL60Mccy7pDEmIW8vNjggz+KfQqVEb7ry1HlgypFECzlS28x0R/YmNWBs5+4MM+eQ41z05bsw0BpF+OcZhjfYjetigtUxhOTN7vsRcGpnWnI0So8eOCbgEq9CklhUWicl/td1b09M744U7Mr/Bi7NlUOYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726580886; c=relaxed/simple;
	bh=KlDLJejjCFlS/Dlw6yFzd1KdagjYSoOiIaAOqNn/nBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FmlZn9E2NHPtoYKJ51mYt0DeYMxEDa69IDsyJJUt9F/FrDPtORS+4JqYNdRRXzzxCDX9tecEbgaEohkSljL+xYwY5cchSr/sXFg8x7GQwNM5j7AIKmFWNMtjc/3brxwyDT6JqOyJEEpC+cz7oQ3Gt9RU8t+O6ODr7micSUE/WEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qFDmLgW+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00762C4CEC5;
	Tue, 17 Sep 2024 13:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726580886;
	bh=KlDLJejjCFlS/Dlw6yFzd1KdagjYSoOiIaAOqNn/nBI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qFDmLgW+rzmWfuSxTWC21lbdssJzd1iCBzbh0mhT089Pj93pi6BZREarokKfs/m9L
	 4NS/miECacT2Y8hfqYH7ybuZgbtVawivAwSjwUkx2WpdkeIz/3FCd6KBWSUtA1Gxnt
	 wVp4oGPVKGrXMS1Fxk9E6oKQX82JIA41OI/39QhXw9ACFFYvKMAY1iB9WMs7CJXGXm
	 66K5nk7XywSfKdev69YZRMBc3h0ur2MM0TJPnFlVqf8g1voLxheS73WapOCL5Jg6ab
	 VNn0wpqMSXh42L2Ty61R77laIRu7cEvml+nDy5/vv+8S9e0yiBZvxa3P4ykLS+Myui
	 7tSJC+7YbRgww==
Message-ID: <b5cfca5d-07ac-431b-8443-6749d9bcc7f2@kernel.org>
Date: Tue, 17 Sep 2024 15:48:00 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] interconnect: qcom: icc-rpmh: probe defer incase of
 missing QoS clock dependency
To: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>,
 Georgi Djakov <djakov@kernel.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>,
 Odelu Kukatla <quic_okukatla@quicinc.com>,
 Jeff Johnson <quic_jjohnson@quicinc.com>, linux-arm-msm@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mike Tipton <quic_mdtipton@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>
References: <20240911094516.16901-1-quic_rlaggysh@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konradybcio@kernel.org>
In-Reply-To: <20240911094516.16901-1-quic_rlaggysh@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11.09.2024 11:45 AM, Raviteja Laggyshetty wrote:
> Return -EPROBE_DEFER from interconnect provider incase probe defer is
> received from devm_clk_bulk_get_all(). This would help in reattempting
> the inteconnect driver probe, once the required QoS clocks are
> available.
> 
> Suggested-by: Bjorn Andersson <andersson@kernel.org>
> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konradybcio@kernel.org>

Konrad


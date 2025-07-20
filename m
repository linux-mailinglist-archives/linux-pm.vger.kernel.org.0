Return-Path: <linux-pm+bounces-31135-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F7DB0B921
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 01:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 561F13B3229
	for <lists+linux-pm@lfdr.de>; Sun, 20 Jul 2025 23:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FFC223DDD;
	Sun, 20 Jul 2025 23:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Er3HiFRu"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F4612CDA5;
	Sun, 20 Jul 2025 23:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753053462; cv=none; b=qqBwpa5uu2FXyC3BJsakevj5ecwPefqYBNBEBC+snWCovXe0q/dwuqKxmHt7a0+DVEoVWp+tnKycSrv/+tbVXyMYgl5I7BLm8wMB+ylPOFhz8c+9P8s0zDDAxUZwtzLMPVMKs97NqKW3NDH1YgS6qaHguKSJWdR7dU+CyYrbr1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753053462; c=relaxed/simple;
	bh=edEvYKZrFrwkZ+75qb5r5pcx+z3myTJ8mTDiuR3q9N0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=da/6NE2uIHelvX/SRpKBH+TGY4t4vlzLcaJd9pJ5IiIuWqeJp4AxDGy/97LC00VG8pQ6+PTqjkQaDkDPec0efu8HT+gTYX+9tYvCrLR6rvMGjmf4esbl2ek2fJdYENzouk2EvO7swy8F0ff9nYq0WBONbdzbkbIMpUZ6d6YWT6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Er3HiFRu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F9C5C4CEE7;
	Sun, 20 Jul 2025 23:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753053462;
	bh=edEvYKZrFrwkZ+75qb5r5pcx+z3myTJ8mTDiuR3q9N0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Er3HiFRuz7T7OLvRY0xIvXsSbZzpanONcA0lJ3cm3AC+nHvWFvqQSEl+cBfq7Uap0
	 fGVWw4hNLXoGD6Ol1hez8wKHQorCoiewHbtDMV7DeKGdYI3MXtJpj8UvSZJNr0zlDl
	 33q5GvHMHdp2SJ6mJjdWbuooTgv2lzdgESK8BoP3YptFu1K8kqtrrAwiRF9QG9a60H
	 ahqM0xgmXzUczeJFqKHELzKSv4qRNkq6EqovRPRsas5qTNlGVeoS0cUM1yua/KS+Ce
	 xBZse4OrXl0c90JjBfc3MvyyNk6gYwN1rgtKL4AR13/l/+cK13SrMVFnkGmiA2wV2G
	 euws38hPWLglQ==
Date: Sun, 20 Jul 2025 18:17:41 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, konrad.dybcio@oss.qualcomm.com,
	lumag@kernel.org, devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org, ulf.hansson@linaro.org,
	conor+dt@kernel.org, kamal.wadhwa@oss.qualcomm.com,
	krzk+dt@kernel.org, quic_rjendra@quicinc.com,
	quic_tingguoc@quicinc.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: power: rpmpd: Add Glymur power domains
Message-ID: <175305346111.3052817.1757228787508793477.robh@kernel.org>
References: <20250716152758.4079467-1-pankaj.patil@oss.qualcomm.com>
 <20250716152758.4079467-2-pankaj.patil@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716152758.4079467-2-pankaj.patil@oss.qualcomm.com>


On Wed, 16 Jul 2025 20:57:57 +0530, Pankaj Patil wrote:
> From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
> 
> Add the compatibles for the rpmpd power domains on glymur
> boards
> 
> Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/power/qcom,rpmpd.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>



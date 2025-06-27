Return-Path: <linux-pm+bounces-29643-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 350E7AEB0E8
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 10:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DBDF16918D
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 08:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F79233140;
	Fri, 27 Jun 2025 08:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BwDkmHTe"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED9C22FF35;
	Fri, 27 Jun 2025 08:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751011511; cv=none; b=lsxL5HVndw33eRnLunPwOlI/tvwuDgfsxpldMY3O7IB43vSwQl7fIkoQHcqc0z3kgzRWZowRlVF/4LyA8yaeb69n0lzTXORP279QaBDHZKMahdu9E7bg0JIXr9qYYs1TTZMmz10KXZ52p7ZwOVIw06oss/qIm3rw9kvEhx+lXNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751011511; c=relaxed/simple;
	bh=HqW5pj+WKoWW4akYDyiA8eDyDswOGGO/4zZsR0+1BBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=STnWqnAbc2IntVygJ/q6/gCQmugC/Xs3LVGhi/c7LrPLuMLUDmci6+5prd3lRYy2kTLarhB0uvsGRXjxBQw2HzE/Qvo6mUYjZiN+2XzCvgdJWxXVSOR+P1xDlBu38ZlH3MW7ue3EVyYimfpgE3dnWpFVLRMK3tk/O8SOy88s3No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BwDkmHTe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CC9FC4CEE3;
	Fri, 27 Jun 2025 08:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751011510;
	bh=HqW5pj+WKoWW4akYDyiA8eDyDswOGGO/4zZsR0+1BBA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BwDkmHTeV4OZHhIeHRkvq5+nb5iIqAaBSg7lNbjoF3hxM51baZI5tDEziLqPxblnW
	 B+BWTiBo2ARL59nqE6oA6qtKIBeb9XbGEBZeeQ+EnYaUPqNqVU3m0ZfnVzi/jf/S1g
	 uwP9Yc6VjNhsDczo0HXe1kBXCqTvoSanDQTWiIzNMoy76qnYBjKVOdODIOQkQ05uzK
	 gOCDCd+AnqvKh7P5wcOy8iKDpOGZa5rf5Oos3vntmgWEhH4TcCncA6HSY136NO+P3Y
	 mm0KqsK3L0zW6jCOy/UagqlvxWynHFj76lUIK3vQjfgZscGTmjvYe3iTWugO8E7zx+
	 PansuTIOHDKBQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uV458-000000007BS-395Y;
	Fri, 27 Jun 2025 10:05:10 +0200
Date: Fri, 27 Jun 2025 10:05:10 +0200
From: Johan Hovold <johan@kernel.org>
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: Georgi Djakov <djakov@kernel.org>,
	Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>,
	linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] interconnect: increase ICC_DYN_ID_START
Message-ID: <aF5Qtp-szaN8VADF@hovoldconsulting.com>
References: <20250625-icc-dyn-id-fix-v1-1-127cb5498449@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625-icc-dyn-id-fix-v1-1-127cb5498449@gmail.com>

On Wed, Jun 25, 2025 at 03:34:23PM +0200, Gabor Juhos wrote:
> Since commit d30f83d278a9 ("interconnect: core: Add dynamic id allocation
> support"), interconnect node ids greater than or equal to ICC_DYN_ID_START
> are reserved for dynamic id allocation. Yet the icc_node_create_nolock()
> function allows to directly use such ids for creating nodes. This can
> cause problems by executing dynamic id related codepaths even for nodes
> intended to use static ids.
> 
> For example, the 'nsscc-ipq9574' driver creates interconnect nodes with
> static ids starting from 19148. Because these ids belongs to the dynamic
> id range, the icc_node_add() function replaces the node names
> unexpectedly.
> 
> The node names looked like this before the change:
> 
>   # grep nss_cc /sys/kernel/debug/interconnect/interconnect_summary
>   nss_cc_nssnoc_ppe_clk_master                          0            0
>   nss_cc_nssnoc_ppe_clk_slave                           0            0
>   nss_cc_nssnoc_ppe_cfg_clk_master                      0            0
>   ...
> 
> And those have an unexpected suffix now:
> 
>   # grep nss_cc /sys/kernel/debug/interconnect/interconnect_summary
>   nss_cc_nssnoc_ppe_clk_master@39b00000.clock-controller            0            0
>   nss_cc_nssnoc_ppe_clk_slave@39b00000.clock-controller            0            0
>   nss_cc_nssnoc_ppe_cfg_clk_master@39b00000.clock-controller            0            0
>   ...
> 
> Increase the value of ICC_DYN_ID_START to avoid this.
> 
> Also, add sanity check to the icc_node_create_nolock() function to prevent
> directly creating nodes with ids reserved for dynamic allocation in order
> to detect these kind of problems.
> 
> Fixes: d30f83d278a9 ("interconnect: core: Add dynamic id allocation support")
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>


Return-Path: <linux-pm+bounces-15465-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D40998C4E
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 17:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37C54B2F3E8
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 15:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD65B1CC14D;
	Thu, 10 Oct 2024 15:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVIZTJrh"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7F61CB53B;
	Thu, 10 Oct 2024 15:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728572565; cv=none; b=gtUBj0uXgBuQho1HV4exdHLciGDRoFbVkb7Hn3msXYSAkizDSGn+r7AzEoM4mOMF2OwuLseyE/TZetwGeksQYX//0ib8+8Tg3c7aJvn34nFDazy3qTSSR7mx6x23PV0WXbgtknGvf46zEWBNSQMZA5XHac1kiqxeSCCwYL74DsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728572565; c=relaxed/simple;
	bh=bjy6e6QEhhN5c+EuFMe9xasd22I0t3FiJxHHAH6y3Do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JBP0mUTLfFq1EScinJefbsOYxNFzSkXQX/6JVgnv0nZlnwoqiN47rAFwGTtb9r3TP5ON5wT8fXtM96VjQ+SkbJleKt45mckHha0rLHmP8p+feTH7zb/GFJjvTe+EGK09PuH1q9IZGj5gvaz8EIxIQ1FLV3vcZh1GgOc1Ln8DIGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVIZTJrh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 394A1C4CEC5;
	Thu, 10 Oct 2024 15:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728572565;
	bh=bjy6e6QEhhN5c+EuFMe9xasd22I0t3FiJxHHAH6y3Do=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SVIZTJrhzvphIu3Ftqo6erLe999jvVlPE+6ogBZaG1lsWXqNtw3gIGYdT64v+6++w
	 W1iIadWdeURCQUaaNAPLtWuWM0iaxcJLGw3n0U0PBCe9j4ytj1KBM2szHu8dDfwsRG
	 gIPoq8BMJLLPvZBGsgI5GXkFbr27Rf1D3WnxXSg6Igl0g3CQ785i6gsbn/lds3d/pG
	 8fNEzco/oFh5l7kUPfmkcpvTclus8NmztH4SCraKVwDS1TUfiFj/3QHTbKsVloOK84
	 466q3ppjnTFTdrI0xAcgjfgf8PRA9N3Ygt6ez0YSXUOonUBixicoABzhy8V7VzEmMq
	 w/rg0Vg1LPHTA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1syugk-0000000084s-0xnH;
	Thu, 10 Oct 2024 17:02:50 +0200
Date: Thu, 10 Oct 2024 17:02:50 +0200
From: Johan Hovold <johan@kernel.org>
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: sudeep.holla@arm.com, cristian.marussi@arm.com, ulf.hansson@linaro.org,
	jassisinghbrar@gmail.com, linux-kernel@vger.kernel.org,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org, konradybcio@kernel.org,
	linux-pm@vger.kernel.org, tstrudel@google.com, rafael@kernel.org
Subject: Re: [PATCH V3 0/4] firmware: arm_scmi: Misc Fixes
Message-ID: <ZwfsmqInJlqkQD_3@hovoldconsulting.com>
References: <20241007060642.1978049-1-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007060642.1978049-1-quic_sibis@quicinc.com>

On Mon, Oct 07, 2024 at 11:36:38AM +0530, Sibi Sankar wrote:
> The series addresses the kernel warnings reported by Johan at [1] and are
> are required to X1E cpufreq device tree changes [2] to land.
> 
> [1] - https://lore.kernel.org/lkml/ZoQjAWse2YxwyRJv@hovoldconsulting.com/
> [2] - https://lore.kernel.org/lkml/20240612124056.39230-1-quic_sibis@quicinc.com/
> 
> The following warnings remain unadressed:
> arm-scmi arm-scmi.0.auto: Failed to add opps_by_lvl at 3417600 for NCC - ret:-16
> arm-scmi arm-scmi.0.auto: Failed to add opps_by_lvl at 3417600 for NCC - ret:-16

Are there any plans for how to address these?

Johan


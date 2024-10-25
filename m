Return-Path: <linux-pm+bounces-16454-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B469B044C
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2024 15:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0CDBB22AA9
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2024 13:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C371D90DC;
	Fri, 25 Oct 2024 13:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EMCSnz6P"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F1B1632F8;
	Fri, 25 Oct 2024 13:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729863568; cv=none; b=TkBFC5OZVgYicRVqt/UWI7xyqfCnLZVdN+yP5KoXMt3QC7mrRgm7E9AWnmf3puaR70lBvBh/5dnFCtZ5wMRKcJSUo3s2ZgYKpRlmZeI9i0FGeop7rjOLHDKoROEctIs7qMX3PB6BpG5I0e9yHKK+9oHiBahWm7GYWb0P53f+gq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729863568; c=relaxed/simple;
	bh=iXshz53UY8Tw9bcTb1F+rkddkrEEDdOWrzrTbynhNCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nqn0btEsU0Of4Fsy12LiUkYRXCmdUjIsVfvyWncntUjdx2xHX0WKIscMpIZ94knSBXuVfbKaFsA9TCbikZXWQsh/6TnEJMObts8s92SM/OzAfmgwhDuhxoHHRmaFGFMiOvjg9wox9lz2ENRK9sc09UG8krEeQBpFaphUYyBkv64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EMCSnz6P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 237A2C4CEC3;
	Fri, 25 Oct 2024 13:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729863566;
	bh=iXshz53UY8Tw9bcTb1F+rkddkrEEDdOWrzrTbynhNCw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EMCSnz6PQUh62zSItP2OLJ+BdaD+t2T5Q2/vMO2BMIG6pl4JMh8zdB/W5Fwu0UcVa
	 0JTDecr9LOCsDwkgy4/yq+MNyztwKV0OPv3PaoO6lKMtWwNCQ1lWkYbGVwFhBTkdBp
	 nWZnTYOmbhoiv5gGoUk0BNU/LyNASN0jUFc90obelR6OSVPpPE6yxe9I5dHHQaXtt1
	 c/gHx4yz3nTeNIsNgz+VD/daN/oFYe2tKATpPQrv4FfBKKKKVuDxb/kATj5V0rslV0
	 OX+f/knTUX++MnzANgBLQ/0nS0QuQlilysAhZ/EBocV/5qC8teiu2big/tvXjZ34Jg
	 wrmqcaHc1gPug==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1t4KXY-000000003M9-2an3;
	Fri, 25 Oct 2024 15:39:44 +0200
Date: Fri, 25 Oct 2024 15:39:44 +0200
From: Johan Hovold <johan@kernel.org>
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: sudeep.holla@arm.com, cristian.marussi@arm.com, ulf.hansson@linaro.org,
	jassisinghbrar@gmail.com, dmitry.baryshkov@linaro.org,
	linux-kernel@vger.kernel.org, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	konradybcio@kernel.org, linux-pm@vger.kernel.org,
	tstrudel@google.com, rafael@kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH V4 1/4] firmware: arm_scmi: Ensure that the message-id
 supports fastchannel
Message-ID: <ZxufoL3NjYs8Lyq0@hovoldconsulting.com>
References: <20241023102148.1698910-1-quic_sibis@quicinc.com>
 <20241023102148.1698910-2-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023102148.1698910-2-quic_sibis@quicinc.com>

On Wed, Oct 23, 2024 at 03:51:45PM +0530, Sibi Sankar wrote:
> Currently the perf and powercap protocol relies on the protocol domain
> attributes, which just ensures that one fastchannel per domain, before
> instantiating fastchannels for all possible message-ids. Fix this by
> ensuring that each message-id supports fastchannel before initialization.

Again, perhaps you could include the error message I reported here so
that anyone searching for that error will find this fix more easily?
 
> Reported-by: Johan Hovold <johan+linaro@kernel.org>
> Closes: https://lore.kernel.org/lkml/ZoQjAWse2YxwyRJv@hovoldconsulting.com/
> Fixes: 6f9ea4dabd2d ("firmware: arm_scmi: Generalize the fast channel support")

And, also again, should you add a CC-stable tag here to get this
backported?

> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> Tested-by: Johan Hovold <johan+linaro@kernel.org>
> ---
> 
> v3:
> * Pick up R-b, T-b from the list.
> * Move scmi_protocol_msg_check to the top [Sudeep]

Johan


Return-Path: <linux-pm+bounces-16281-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E077F9AC18A
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2024 10:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C65F1F22DC0
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2024 08:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B51158851;
	Wed, 23 Oct 2024 08:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QuGXHLUD"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953D7487BE;
	Wed, 23 Oct 2024 08:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729672023; cv=none; b=pQO33YwJxHtFGhD7CvPIB7jy1+PlM0VtgB7ijjxFCz4/9uHLHr2GNcOHm9hrvo2dYK+NedEJGIgtaV2tablYtAg65omOilW4WeZ6vcNwr2U7N1wIqN4DOxu41aOlQxte31Af+UsobkLQZ9x/EtHzVQ7h7C7EnrMIN4dwy8espwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729672023; c=relaxed/simple;
	bh=3aIUdg+tax4FMv8WejioXhpEd1hzHB0Se2frFked5Dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aufe2PNDdAYDBaJfnMrSY+Mslx+qgoYqEuAf/mrg8xojhWNaFcKZbZSRKbm+n8gHikK9QdoOqcDwLunnWx5NW2qw46OJ76SPc5+1g3xtEAQwNm43UxQxmLeTPlPF3m6JocVt57kXKq+KjO3knwu1zGN2jOUD2Ck3HMGvX8opeuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QuGXHLUD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80BA8C4CEC6;
	Wed, 23 Oct 2024 08:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729672023;
	bh=3aIUdg+tax4FMv8WejioXhpEd1hzHB0Se2frFked5Dg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QuGXHLUD+moqSLAw6Br0rYZZJdmTYWiHQ0pM79JqC3JgeZj+PJlwPtozm52vUkSOE
	 24nvhbXFrbVW57KvGYWixwXGpAps+M6wIy7ZttH/1rgOc99nsKfdO5If7psNDLu5q6
	 kIqZshWlgK/5jAoud8r6oN/fBPfZaQZf/kHM1nVsPmf509X4CJWWU8sOBKLiydyowH
	 Lbpq3JFSMjMGbTO6mkIgGAogCEXKe+RU1Txpt145HyqBiq0DM19KexXokzryCdB4el
	 20mRfuVV8Dcw/5fA4c2TCzR6BQeX9VAgKsU4krtV5TOwO2Fh8W3viUsjzZWWdc1FXV
	 KLH7frhU9JiXg==
Date: Wed, 23 Oct 2024 10:27:00 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Melody Olvera <quic_molvera@quicinc.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Adam Skladowski <a39.skl@gmail.com>, Konrad Dybcio <konradybcio@kernel.org>, 
	Sibi Sankar <quic_sibis@quicinc.com>, 
	=?utf-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>, Vladimir Lypak <vladimir.lypak@gmail.com>, 
	Danila Tikhonov <danila@jiaxyga.com>, Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Rajendra Nayak <quic_rjendra@quicinc.com>, 
	Mike Tipton <quic_mdtipton@quicinc.com>, Abel Vesa <abel.vesa@linaro.org>, 
	Trilok Soni <quic_tsoni@quicinc.com>, Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: interconnect: add interconnect bindings
 for SM8750
Message-ID: <xirucdmwgo5borqgaofmow6ptf3wzgseiivjptzpjulfupmfyx@2fofyhc2vm5o>
References: <20241021231823.2635534-1-quic_molvera@quicinc.com>
 <20241021231823.2635534-2-quic_molvera@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241021231823.2635534-2-quic_molvera@quicinc.com>

On Mon, Oct 21, 2024 at 04:18:21PM -0700, Melody Olvera wrote:
> From: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
> 
> Add interconnect device bindings. These devices can be used
> to describe any RPMh and NoC based interconnect devices.
> 
> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof



Return-Path: <linux-pm+bounces-3969-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1618485759B
	for <lists+linux-pm@lfdr.de>; Fri, 16 Feb 2024 06:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0F34283045
	for <lists+linux-pm@lfdr.de>; Fri, 16 Feb 2024 05:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB83212E63;
	Fri, 16 Feb 2024 05:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SPWwH3Kq"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E58912E5D;
	Fri, 16 Feb 2024 05:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708061388; cv=none; b=Pw0qzFxlJ4CGg2MEGKpf/Ra2GU0+Qe5v+4s6uouDpBIqLVHOqhIa/2rOKLwKbAqZbhU4iB1ignYj+I+IQti8v92CX8SXyGmVsd0Rn09LFJQKVTakCfJWt9Q7juxa0P/6G0zPaBKzh9AWyvcnX6oeCvBuLhzrcX9K50cxWABBBTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708061388; c=relaxed/simple;
	bh=IlgVpdbZwfG7QKElQzOVJa2V0FaD5FA8QeapNLYDRzg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kdfF1CRvv6+EHqGhIXytwV1vBqO/O/yXl6ckqCFDvIKiJFWVBUC0M9WINvYY6x6/eSwpfBXjWO2laG5sl5EdmK8AG07k7aucI2ngcQ3Fcln5wff1T5fq8HMSPXGlNlpJ3uMGwov+2YoO+rSYpZzA9F8jeqkd5kLk3gcZ2rFZo3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SPWwH3Kq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CE0AC433C7;
	Fri, 16 Feb 2024 05:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708061388;
	bh=IlgVpdbZwfG7QKElQzOVJa2V0FaD5FA8QeapNLYDRzg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SPWwH3KqTpK6v4QT5/t0js00bBWjJ+zLNf39IDzlb8DheT+fAda9INhtccmpbFRqX
	 7NxUdOrPaBBg+8LZtNYaWrKHxYiLTljyQdDvuPpknjNWG+zYGLmtR/itSutCvk0N94
	 zFr83lClvnE3bWfkBs+IcvTwJ9ID2IKSCxWuz51qhVWw4b1kLBcl+UatvISmI60/yK
	 raAlm9ko4zpxMQjgbJ20BaV2iNGCQE3dsONLqPxqwbGO/MuG9RODcZyxyFZgspt8E8
	 CcItH5OLqHuK80BcJl+6k/aHFkayrA+Q0KmL91lXl03jOzw9SLJgGSPi2kc27tzWzN
	 tpKghy7tFkuRA==
Date: Thu, 15 Feb 2024 21:29:46 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Ricardo Neri
 <ricardo.neri-calderon@linux.intel.com>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko
 <jiri@resnulli.us>, Johannes Berg <johannes@sipsolutions.net>, Florian
 Westphal <fw@strlen.de>, netdev@vger.kernel.org
Subject: Re: [PATCH v4 0/3] thermal/netlink/intel_hfi: Enable HFI feature
 only when required
Message-ID: <20240215212946.08c730d9@kernel.org>
In-Reply-To: <20240212161615.161935-1-stanislaw.gruszka@linux.intel.com>
References: <20240212161615.161935-1-stanislaw.gruszka@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Feb 2024 17:16:12 +0100 Stanislaw Gruszka wrote:
>   genetlink: Add per family bind/unbind callbacks

genetlink patch is now in net-next, and pushed to a 6.8-rc4-based
branch at:

 https://git.kernel.org/pub/scm/linux/kernel/git/kuba/linux.git
  for-thermal-genetlink-family-bind-unbind-callbacks

for anyone to pull.


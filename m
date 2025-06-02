Return-Path: <linux-pm+bounces-27975-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38730ACBBFA
	for <lists+linux-pm@lfdr.de>; Mon,  2 Jun 2025 21:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53A101890A35
	for <lists+linux-pm@lfdr.de>; Mon,  2 Jun 2025 19:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5092253E9;
	Mon,  2 Jun 2025 19:53:41 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39FD229B18;
	Mon,  2 Jun 2025 19:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748894021; cv=none; b=sLbjDfllojxNpgj3EbVEZQyEJO9Qu3JmD7q5lxIQHli5wjbFTe35Gfn4W6BmkeFB1N1WBXWpRygBMG8wg208tjE7ggO7HcY0ZZ8Mv8F4HQSSrj4tfZwlNKqKxtbAw39OnauNRCVGa4BTra7SQ/tZx56GN9JfkIp0ahyJ6f1cGis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748894021; c=relaxed/simple;
	bh=OP23uEfHXl1amO04OXMvRIIhq0jJ+wGQl9T29QAiXOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nxseij+Xa0oobcBdaMjIzJJaNYkgO3CjcXd6zqWeQ5E/Vhsu8S+ObKCXtmMhIZrRrQDsk5OHThRSAjwRBUYXjjQ/bfSItHqhsYPtlEs3wucKb0SRcTLSvsCc5Jt+NgHt1oK3XUCnrDb8pGJab+9OT+GgjiP54IgCbrx2NDfTOyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 75F7D2C0161A;
	Mon,  2 Jun 2025 21:53:30 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 5AA2DDDCC8; Mon,  2 Jun 2025 21:53:30 +0200 (CEST)
Date: Mon, 2 Jun 2025 21:53:30 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Changwoo Min <changwoo@igalia.com>
Cc: lukasz.luba@arm.com, rafael@kernel.org, len.brown@intel.com,
	pavel@kernel.org, christian.loehle@arm.com, tj@kernel.org,
	kernel-dev@igalia.com, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/11] PM: EM: Add a skeleton code for netlink
 notification.
Message-ID: <aD4BOga3GvPewnqI@wunner.de>
References: <20250529001315.233492-1-changwoo@igalia.com>
 <20250529001315.233492-3-changwoo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529001315.233492-3-changwoo@igalia.com>

> diff --git a/include/uapi/linux/energy_model.h b/include/uapi/linux/energy_model.h
> new file mode 100644
> index 000000000000..42a19e614c7d
> --- /dev/null
> +++ b/include/uapi/linux/energy_model.h
> @@ -0,0 +1,40 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#ifndef _UAPI_LINUX_ENERGY_MODEL_H
> +#define _UAPI_LINUX_ENERGY_MODEL_H
> +

It looks like you created the header file manually.  There is tooling
to auto-generate all the boilerplate code from a YAML description in
Documentation/netlink/specs/ and my (limited) understanding is that
using it is mandatory for all newly introduced Netlink protocols.

I just had to wrap my head around all that for SPDM (a device
authentication protocol), see the top-most commit on this branch,
which is in a WIP state though:

https://github.com/l1k/linux/commits/doe

Basically you create the uapi and kernel header files plus kernel source
like this:

tools/net/ynl/pyynl/ynl_gen_c.py --spec Documentation/netlink/specs/em.yaml \
  --mode uapi --header
tools/net/ynl/pyynl/ynl_gen_c.py --spec Documentation/netlink/specs/em.yaml \
  --mode kernel --header
tools/net/ynl/pyynl/ynl_gen_c.py --spec Documentation/netlink/specs/em.yaml \
  --mode kernel --source

And then you add both the YAML file as well as the generated files to
the commit.  The reason you have to do that is because Python is
optional for building the kernel per Documentation/process/changes.rst,
so the files cannot be generated at compile time.  It is possible though
to regenerate them with tools/net/ynl/ynl-regen.sh whenever the YAML file
is changed.

The tooling is somewhat brittle, see 396786af1cea.  In theory ynl_gen_c.py
is capable of auto-generating code for user space applications as well
but it crashed when parsing my YAML file.  So there are more bugs,
just haven't had the time yet to fix them.


> +int __init em_netlink_init(void)
> +{
> +	return genl_register_family(&em_genl_family);
> +}
> +
> +void __init em_netlink_exit(void)
> +{
> +	genl_unregister_family(&em_genl_family);
> +}
> +

It looks like em_netlink_exit() isn't invoked anywhere, so why define
it in the first place?  You only need this if the feature can be modular
(which it cannot - it's gated by a bool Kconfig option).  Then you'd
call em_netlink_exit() in module_exit().

Also, you may want to consider moving this to patch [03/11], where
em_netlink_init() is actually invoked.  And you may want to move the
postcore_initcall() to this file so that you can declare em_netlink_init()
static, don't need em_init() and don't need the empty inline stubs.

Thanks,

Lukas


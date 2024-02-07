Return-Path: <linux-pm+bounces-3510-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B008D84C291
	for <lists+linux-pm@lfdr.de>; Wed,  7 Feb 2024 03:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CF9EB26123
	for <lists+linux-pm@lfdr.de>; Wed,  7 Feb 2024 02:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F8AD528;
	Wed,  7 Feb 2024 02:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DInrIvJc"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19A4F9DA;
	Wed,  7 Feb 2024 02:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707273725; cv=none; b=cuRj6UCapbDnNSq/qlutIc403Gr7JRbngxy9weSOeP4n4dPOTDhFV856k2wyXqW5HUGDbqPX6C2A6tnsR8Zdne9XAywdriGWoD6yqE2VBWVXbok6G3Q7mJlhrL3VGkUHAiMwyXD4ulRV9sEkK8go0Kv3b424jIadilildjnj7P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707273725; c=relaxed/simple;
	bh=KqdTQlE9n+pcxn54PEEOzOz103tE1dBz1xoavx0jeEM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jMFX51Kys32pmkILead6kaPgIFgDPXOcxJLHAgZAxMbuv7zqSN+erFe63PkzsUeN4l4aR30wzvbbkxnT+QmPk829Vov/swIiRVY2RxUzGIKNr7zkLOCysUnTOQvuqedZod2BqGzd3uEJsbW+A7Z4AVa14LBQObESW9tpbvbuFow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DInrIvJc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E30EDC433F1;
	Wed,  7 Feb 2024 02:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707273724;
	bh=KqdTQlE9n+pcxn54PEEOzOz103tE1dBz1xoavx0jeEM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DInrIvJcpYBL8rWmUTYRQA9oF4iS/QMZrpNtaXmbjWvwbhJGvhEPMYpb8GIRqB0I1
	 DTgce3OUJLLVHRSB7CxaVGBoqmJcemVIStiV3wz3/D8PiFqdjzEc2luBUrLYQNa0In
	 8b7rv24h4Q6NtpxZ8LdZcegXUVI4PPAbN+Ip3sYx+sDcpNgS48tB/yQ5wU6QUBwSDX
	 NLKvY8JnKFyxM3oHznvzbn/TUrOhuYUAOEsBvTJpz63HcDRURRsyR8tCVJKQc3BCKK
	 Z+RrtU91qUWG6Obbj2k85qUNUr0trc+XG46tra/hZhZr7n1frq7QFbXnb9J/IAuK4d
	 NLBVbvx247yCg==
Date: Tue, 6 Feb 2024 18:42:02 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Ricardo Neri
 <ricardo.neri-calderon@linux.intel.com>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko
 <jiri@resnulli.us>, Johannes Berg <johannes@sipsolutions.net>, Florian
 Westphal <fw@strlen.de>, netdev@vger.kernel.org
Subject: Re: [PATCH v2 1/3] genetlink: Add per family bind/unbind callbacks
Message-ID: <20240206184202.3089c098@kernel.org>
In-Reply-To: <20240206133605.1518373-2-stanislaw.gruszka@linux.intel.com>
References: <20240206133605.1518373-1-stanislaw.gruszka@linux.intel.com>
	<20240206133605.1518373-2-stanislaw.gruszka@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue,  6 Feb 2024 14:36:03 +0100 Stanislaw Gruszka wrote:
> +static void genl_unbind(struct net *net, int group)
> +{
> +	const struct genl_family *family;
> +	unsigned int id;
> +
> +	down_read(&cb_lock);
> +
> +	idr_for_each_entry(&genl_fam_idr, family, id) {
> +		const struct genl_multicast_group *grp;
> +		int i;
> +
> +		if (family->n_mcgrps =3D=3D 0)
> +			continue;
> +
> +		i =3D group - family->mcgrp_offset;
> +		if (i < 0 || i >=3D family->n_mcgrps)
> +			continue;
> +
> +		grp =3D &family->mcgrps[i];
> +
> +		if (family->unbind)
> +			family->unbind(i);
> +
> +		break;

Compiler says:

net/netlink/genetlink.c:1857:52: warning: variable =E2=80=98grp=E2=80=99 se=
t but not used [-Wunused-but-set-variable]
 1857 |                 const struct genl_multicast_group *grp;
      |                                                    ^~~
--=20
pw-bot: cr


Return-Path: <linux-pm+bounces-43017-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAPGM84tnGmIAgQAu9opvQ
	(envelope-from <linux-pm+bounces-43017-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 11:37:02 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF303174FBF
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 11:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9792F301F69D
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 10:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC86352C54;
	Mon, 23 Feb 2026 10:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g018biIb"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C413EBF08;
	Mon, 23 Feb 2026 10:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771842975; cv=none; b=P783hxqS5GPMFAoDlUoQw61bXDz2g0/BZNao60qvdJTQIVH5W82mlLXp3afo1ctCBJvQWbIcpJwk4W/oq2nMN7luRdghwK0Rm+tciRR7Zmfp4BsTPyMn1JGKn5X0C9/FUSw7M4061DcvyaIM1AQR/mOSBVj2AQ8OuRXVP5z6Jbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771842975; c=relaxed/simple;
	bh=AiVxbYjTjkFCDusZ5tWu7n3s2U71UIpWbTezPnBHohQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=fwbZGARCuVr8IQ5jCrO5IZLSYgYdDlr5+FTlevUNNwbb2fxQNeUynsrq0LStNnbVL/Ukf5MnwBhp47X1gGXXM2VvSBPmERZmhQr/49HGlwmwXkB3ZMuuvXrh/el1HahphP4OPXpaD1ZQpcnLXUg6HvlJwUYBJNAqFa5U5Cz9nVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g018biIb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50DB8C116C6;
	Mon, 23 Feb 2026 10:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771842975;
	bh=AiVxbYjTjkFCDusZ5tWu7n3s2U71UIpWbTezPnBHohQ=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=g018biIbLMWiMgHMZWobv71WB0aDNk0V5mHABji3/oQj3XLzM55HPmrBH+gw8NLP9
	 4aFelAoKv77LNIwGM+/LTapuKx9mVvzEJ2L301pPtTMtOM0r8aXiVRj5h0tlOYPnq0
	 brl1ukA+PDKddKhXcBHoVMuJcO/8RzmbIldDMOOJjgUT92rUnefSZbuOXkTIRjUX9P
	 joksQ/AF6fENHVP37XJW5oZWiAzNSPklNWkkCfGuG5kfnx5WJyX+qqe/Cp7gpQNvkT
	 FOUUUbuXuikeaIw63y50ihIesqm1gE1hUP9Cy1hgtbOVFCRNlNdZfvKbHVgxwQe8ft
	 zfydjoMRh3uMQ==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Feb 2026 11:36:08 +0100
Message-Id: <DGM9WUWC4ZE8.1A08TAKKT4FLJ@kernel.org>
Subject: Re: [PATCH 1/9] workqueue: devres: Add device-managed allocate
 workqueue
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>, "Shuah Khan"
 <skhan@linuxfoundation.org>, "Tejun Heo" <tj@kernel.org>, "Lai Jiangshan"
 <jiangshanlai@gmail.com>, "Tobias Schrammm" <t.schramm@manjaro.org>,
 "Sebastian Reichel" <sre@kernel.org>, "Andy Shevchenko"
 <andriy.shevchenko@linux.intel.com>, "Dan Carpenter"
 <dan.carpenter@linaro.org>, "Krzysztof Kozlowski" <krzk@kernel.org>, "Lee
 Jones" <lee@kernel.org>, "Dzmitry Sankouski" <dsankouski@gmail.com>,
 "Matthias Brugger" <matthias.bgg@gmail.com>, "AngeloGioacchino Del Regno"
 <angelogioacchino.delregno@collabora.com>, "Benson Leung"
 <bleung@chromium.org>, "Tzung-Bi Shih" <tzungbi@kernel.org>,
 <driver-core@lists.linux.dev>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Sebastian Reichel"
 <sebastian.reichel@collabora.com>, <linux-pm@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-mediatek@lists.infradead.org>, <chrome-platform@lists.linux.dev>
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@oss.qualcomm.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260223-workqueue-devm-v1-0-10b3a6087586@oss.qualcomm.com>
 <20260223-workqueue-devm-v1-1-10b3a6087586@oss.qualcomm.com>
In-Reply-To: <20260223-workqueue-devm-v1-1-10b3a6087586@oss.qualcomm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43017-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,lwn.net,gmail.com,manjaro.org,linux.intel.com,linaro.org,collabora.com,chromium.org,lists.linux.dev,vger.kernel.org,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EF303174FBF
X-Rspamd-Action: no action

On Mon Feb 23, 2026 at 8:27 AM CET, Krzysztof Kozlowski wrote:
> +__printf(2, 5) struct workqueue_struct *
> +devm_alloc_workqueue(struct device *dev, const char *fmt, unsigned int f=
lags,
> +		     int max_active, ...)
> +{
> +	struct workqueue_struct **ptr, *wq;
> +	va_list args;
> +
> +	ptr =3D devres_alloc(devm_destroy_workqueue, sizeof(*ptr), GFP_KERNEL);

The function pointer passed to devres_alloc() is commonly named *_release()=
.

> +	if (!ptr)
> +		return NULL;
> +
> +	va_start(args, max_active);
> +	wq =3D alloc_workqueue(fmt, flags, max_active, args);
> +	va_end(args);
> +	if (wq) {
> +		*ptr =3D wq;
> +		devres_add(dev, ptr);
> +	} else {
> +		devres_free(ptr);
> +	}
> +
> +	return wq;
> +}
> +EXPORT_SYMBOL_GPL(devm_alloc_workqueue);

<snip>

> +void devm_destroy_workqueue(struct device *dev, void *res)
> +{
> +	destroy_workqueue(*(struct workqueue_struct **)res);
> +}
> +EXPORT_SYMBOL_GPL(devm_destroy_workqueue);

I assume you did not mean to export the release callback (which doesn't see=
m to
be useful), but a function that calls devres_destroy(), i.e. something anal=
ogous
to devm_remove_action().

If you don't actually need it, I would prefer not to add something that cal=
ls
devres_destroy() for now.


Return-Path: <linux-pm+bounces-41601-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QA+hMmHmeWl60wEAu9opvQ
	(envelope-from <linux-pm+bounces-41601-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 11:35:13 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F03E79F8A6
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 11:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C8C793015FCF
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 10:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EA92EB847;
	Wed, 28 Jan 2026 10:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DYxwjqLB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B87C29AAFD
	for <linux-pm@vger.kernel.org>; Wed, 28 Jan 2026 10:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769596430; cv=pass; b=R0ukTMDvLU5Vqdc45xGl4lwd9QtZrgjaZjiO/+G+eco50cU/8fvrJo4/jr/Lo8UCVR2oioYjqL+Vc++f7E3HBsTjRBHAU94Fr/Wy2jUddnFJcy/QfmxX1DL72YBSZLSwsysUJJPaa4ZhWtEZLPeTSnbUOB5SQeEIHIj7BZRxTGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769596430; c=relaxed/simple;
	bh=SOof+8DArQi9UZz4+nMwthMoxwT/Vl1hA1uqJmiL/Ek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sc0yoRj4I2yR+E+2IpawsLdYJb8X2vl1+aECvqHfC/PLfjIX67xpuxvc8Gw6TVn19k1xU71E6AT2Zj2eaahKTbwI1GBIZ8WurFvpM0yqVzi/tfy09pjZwcYFPXtZ1Hy5zXkOrQDQDIGM/z/HBn2ix7WTu0WL0iJD8S14zoNLCgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DYxwjqLB; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-59b6c89d302so6526899e87.1
        for <linux-pm@vger.kernel.org>; Wed, 28 Jan 2026 02:33:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769596427; cv=none;
        d=google.com; s=arc-20240605;
        b=V4TIuWjQ8M8ewB430xwwqmHf5ny3FdMiTNDxUjfBdycafxjmN11cOZkK8kl8P25IXK
         y5iR0EsNsomvYJG94vNEWpNTCEIPGBA60hJjWcAJxB5gGwAn+5yzg3W2Zig6DMGkd873
         nXpbyB4Dh8CyunK+MxqeakaYZXGnFMUi9x6+kYwoAmDrObv+QqFX2ty2zQQicPZInrgg
         DdHGG4RzO4yXhR/Ea4yBecUwEpf9VCdp2csXWP0HlnmNEAY+95xyHbDmBmd6gKlLQcjc
         Kl9Qm+m0NSF3oQi/7uu7SHO2m01N8jco0m1DxZgvT5EzhRUNQREO2hRDLDpYIgJ/CT2g
         2voA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=H+89Kw1FwZw/S2Y7rHaGR1GdDk3woRf2HpjVQHEpds4=;
        fh=aoKzLRKYBLStCGnzYRbZtfrwyFPVmuWr3QG7Pdzn+0E=;
        b=HXLm7uA0ATYLvd8OX6bfrewOxXX4+ST4zQFHxzU9k7rWdRQeg6O1BeRlPTxtu7iA+D
         iUKzNFW0H9bc9F14InkPp9QGYoskiwSj5iGs5q1QfiQu5ANDivdVKvJybLkNp6R9Ky4a
         Opwkz086K5pARVf4WxMMJTh/tOgjbRFNiVpTJZhdMInyEUryclNkxEK7ojgvtLejyoQ4
         fAqO6smmt7DqdgTFkhBdirIGMEv0E5DBlOzpzEpnODDxn5U6K7yrsHL9kyghBdDTsyb6
         FYIuqEJXaBtuJ3Ghihg1EzUZcCzMZPPkM574IvojSz8IaSt87JHNYpck/qf0R+jl9SnJ
         wIWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769596427; x=1770201227; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H+89Kw1FwZw/S2Y7rHaGR1GdDk3woRf2HpjVQHEpds4=;
        b=DYxwjqLBlX4W6Mrja1lZT8zoWlTMwifjVlUdD0Z8CY/R7VovXnWMla2KNjsrmDOavD
         +2u/fN2qihWFpyR7dgRjM5Oz7VDT9wBdcTxWH58r+7hRbQSjCdsiQgtEMJbNFzY7WVcy
         aP9u3oDBoqRCE7l325dKWq23incgHP0bA48FkQsKriGN4e14OJmzixA0mhXxWhOo+Glv
         fxBof7sV4UWcG80+Bi/ZWbQuq02Ntx/XgPyyE/vesBhwnokDfd6+1B3TQlC8tWv0IgSU
         9zE9GEqCid9UQeZVhB6/5eIVl9uAw1GvpHEV42eN9kEkUeBmgr1ZJhybYvtYct5hvWwp
         8hhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769596427; x=1770201227;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H+89Kw1FwZw/S2Y7rHaGR1GdDk3woRf2HpjVQHEpds4=;
        b=kfcXht8GDuOGce0Jyjx2gQJjSHXVdjPWRe/A+N5duS/4tCeLMGxlhGEkTR3GBSMFEk
         ISUwpwR5cK8dNXjjDDoTfZkSk0SzyyzzgPk59/IzgbQBEewjY3EFXtwevAGJllix6R7q
         rSlhj4S9v5s3DXRyrX2G/Fb8ZNVjwP9w1hKNk1w3Zmo2fHK+TnQvpaZTX2Y8opUTgtXW
         mv3WjhymhQVNEGeZi+VBu5fexyDRc80M+ZErSY/cigmdTWwtyiQoJSRHR+HcMMDclHob
         7oa4N/NJsCBkHTUvDEqRLJvhAdyuZyU+jKTVvPzHPFm2hRHQUXaPWVbVqhj5gIcCfEjJ
         dH/A==
X-Forwarded-Encrypted: i=1; AJvYcCVhEtZryMGZ7izR4vlJZqbUr0+U5wwPSPhNc8L+W4Ir8nYTu5+4qpQsMAYp4klBLLLrNgYiRK7lzg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzNAIvfP56rOLg7YtOXuVOdZvTyE+ACUB7Y/yShyMLXZ+vA+TQx
	4/GHOnYb9X8DByjyleyBHE4isygexQaUq4b8eu73Y3YtF6XEE0Fc9F0vS8NFMapTTV+y0jRkNBF
	xhgO7FVYjHY0uN1ZJDoGN8lhtyPheKOzyzX1UW6SD8g==
X-Gm-Gg: AZuq6aKAVeX9tSf8NI5+tkhG/+rMOkSdEKuRgJ9yjEoiTvFAOaxGMSW6p6PNb+x6c9c
	OmEwuUv+nV2qzTvOVBFIpwAF/P8xyIXMgFqmrkUbnh38T7/YJ8aSXVjlua7w03oayLhh8lV8bqf
	U3dpgIeTTshCCbBWktoc0UKgAAfR/1r31cVBS0LDiIxRAOsxStXuue39StbqnN0PYm02AwrpTUB
	e6g5iRmEPEoWlsHhBrl7hG30a3vpiiChEFQYbIyHDCog2QSR90xR46IhHK/FO20EKQvTIpukD38
	M0FfEXQ=
X-Received: by 2002:a05:6512:1393:b0:59d:e351:c339 with SMTP id
 2adb3069b0e04-59e04137389mr2167226e87.48.1769596427170; Wed, 28 Jan 2026
 02:33:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120-topic-lpm-pmdomain-device-constraints-v1-0-108fc4cfafce@baylibre.com>
In-Reply-To: <20260120-topic-lpm-pmdomain-device-constraints-v1-0-108fc4cfafce@baylibre.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 28 Jan 2026 11:33:11 +0100
X-Gm-Features: AZwV_QhAwvE3tTIUiJKtl1i7oYvXgt1yZC_fLcwXQjQaXvAbriyM8gMP7TreRV8
Message-ID: <CAPDyKFr+OjWLnzxBOhfJaMZb1GY7axgyeUAPinQTXMB6Ngpz8w@mail.gmail.com>
Subject: Re: [PATCH 0/2] PM: QoS/pmdomains: support resume latencies for
 system-wide PM
To: "Kevin Hilman (TI)" <khilman@baylibre.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	Dhruva Gole <d-gole@ti.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[ulf.hansson@linaro.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-41601-lists,linux-pm=lfdr.de];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Queue-Id: F03E79F8A6
X-Rspamd-Action: no action

On Wed, 21 Jan 2026 at 02:54, Kevin Hilman (TI) <khilman@baylibre.com> wrote:
>
> Currently QoS resume latencies are only considered for runtime PM
> transitions of pmdomains, which remains the default.
>
> In order to also support QoS resume latencies during system-wide PM,
> add a new flag to indicate a resume latency should be used for
> system-wide PM *instead of* runtime PM.
>
> For example, by doing this:
>
>    # echo 500000 > /sys/devices/.../<dev0>/power/pm_qos_resume_latency_us
>
> dev0 now has a resume latency of 500000 usec for runtime PM
> transitions.
>
> Then, if the new flag is also set:
>
>    # echo 1 > /sys/devices/.../<dev0>/power/pm_qos_latency_sys
>
> That 500000 usec delay now applies to system-wide PM (and not to
> runtime PM).
>
> If a user requires a different latency value for system-wide PM
> compared to runtime PM, then the runtime PM value can be set for
> normal operations, and the system-wide value (and flag) can be set by
> userspace before suspend, and the runtime PM value can be restored
> after resume.

That's sounds complicated for user-space to manage - and causes churns
during every suspend/resume cycle. Why don't we just add a new latency
value instead, that applies both to runtime PM and system-wide PM,
similar and consistent to what we did for CPU QoS?

Kind regards
Uffe

>
> To: Rafael J. Wysocki <rafael@kernel.org>
> To: Ulf Hansson <ulf.hansson@linaro.org>
> To: linux-pm@vger.kernel.org
>
> Signed-off-by: Kevin Hilman (TI) <khilman@baylibre.com>
> ---
> Kevin Hilman (TI) (2):
>       PM / QoS: add flag to indicate latency applies system-wide
>       pmdommain: add support system-wide resume latency constraints
>
>  drivers/base/power/sysfs.c  | 27 +++++++++++++++++++++++++++
>  drivers/pmdomain/governor.c | 42 +++++++++++++++++++++++++++++++++++++++++-
>  include/linux/pm_qos.h      |  2 ++
>  3 files changed, 70 insertions(+), 1 deletion(-)
> ---
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> change-id: 20260120-topic-lpm-pmdomain-device-constraints-e5e78ce48502
>
> Best regards,
> --
> Kevin Hilman (TI) <khilman@baylibre.com>
>


Return-Path: <linux-pm+bounces-43462-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPsmDxocpmmeKQAAu9opvQ
	(envelope-from <linux-pm+bounces-43462-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 00:24:10 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9DF1E691D
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 00:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 30FD030374B9
	for <lists+linux-pm@lfdr.de>; Mon,  2 Mar 2026 23:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACE8331203;
	Mon,  2 Mar 2026 23:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RSvBRC/d"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3E232E73E
	for <linux-pm@vger.kernel.org>; Mon,  2 Mar 2026 23:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772493835; cv=none; b=SD3FtG/B1PNO9oxs21Bbb1Zba3xKqI0oUUOdX2rZe9JfhipFzoPfmSbgaud3b/8tOX6fiZzBlwOW/2aQ2bEDJg0HsSJ/KYdpJ9wTJ+XrLtoa4OzcLQsGgO1bjNZw0/LP3NragzSYs9xmo44GRlnuhn8n8OP7gd/Z0sbV8LrY2jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772493835; c=relaxed/simple;
	bh=R+OnIhGUZG6A7u0+ocY6sf2SrkYnjLzPYEDeBTYUPVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=POeNAxuxBkHqt9lrA3b6fc3P4PP4Ad1gcDw74z/7LzJz7RBjomuBJ8+I/TipxmD8zh2z6vkgctiFrjBQ2ZYbAap5DYaQQiKg8Lu7mxouiMsM+kavemK0g+ZmjJNlldLQT9uyDe5paErKPiVSLml/UKJAGrzf47d14gpX1VQ8SlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RSvBRC/d; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-389fad34e2eso81104591fa.3
        for <linux-pm@vger.kernel.org>; Mon, 02 Mar 2026 15:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772493832; x=1773098632; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jdtHpDW016K4LQxH2pvRVvZZF33gdKrW39HaViFcm2Q=;
        b=RSvBRC/dL9ZlMJ3FolaO0fYlNRCqSkU0N2vbz3BfgIVQBcK1Rmp/bdQvFQTYBtaRVy
         j+jU8fJRJ11bmm9RmP1Z4OM1/tzaUIHWkGyfX6QareT9uBDMUzAne0MMKGnE5YgfbavP
         yUur5H1RD4EWQtuqDD1sRAp4IodK/3m1NGiIrjbIDLMYdB+DaD2LK3J2ns7g4Tql9Ajw
         rdqzU0yfNLrTLN3JkvHzfT5t1we5Xe1+zsbLCqoo5QVwBiE5xv9jhbcP6BldgHTUL0JA
         P5DSolYfjHNl7awYbMap8c16WkHOUWwXXcZYoUgX/sDe+GhqrfZ4OdoH6ZlNsNiCajq9
         KEiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772493832; x=1773098632;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jdtHpDW016K4LQxH2pvRVvZZF33gdKrW39HaViFcm2Q=;
        b=KzZ1+ON66G3gDlYp+ofQu24QTkNDB0psNpQfBr/UTKJ+qTutD3SxxlcYc8J7C7ts6M
         S6+He2EzAJHQAwu7q3+ces/HAp1fzYH0jS+gvOWAXjWbjxnHUI3VntczWrjsYNIiv0rL
         Kemnzt2H5LXInGfqs0a/5FcZrz19thsMR9ZDGcivEAJaL4nhauoyLfVBuEdVA/EN98+W
         Ik1lNH/LYPd8sZsRvHgzYhSyYWkHWXka1HmuBKl7a+B4qYmiWBrHEU64mR4RhK9rNpWC
         CGEsTxp9JNGGTBkM3J/ozYPTBIDpLXpJqWu5ZuzpHNSE+73mLaeyi9fXgz0/o5DzlR9c
         K4Fw==
X-Gm-Message-State: AOJu0Yz5e8ERBQLjYeowyrL+Pn2zXCPMuoWJNnPkHcptVLyzBIZCrkpz
	NPfw0X4rjXOvfnU55rVqeftLSEpgijTces52a7xy9b/AFB7AGhciFoj5
X-Gm-Gg: ATEYQzwrTVCG9cK8RWhyDBb5XCFRSo0fS4/KHWb7s/2BeUFTF7UNogC6yLBb6+3XwB4
	cYTA3cZa1wARr9Axt3aDE+0ux9crsBH9xL/hULgbArO1sy+4eLqW0kgoHzzzxagBkQftaBbWEbd
	kqqKz2LydNDhbKv3D1ry9YdseB+6YvfrRJrlmV6xdeEpO3ab1BafWFqWUCgPKSm2jhtw907c5U9
	xf9YsABbL6M8uD5z8kWoG/UnA7a0Jyuztbd18mROCYplAa+T0/4xyyoQ5e/NC/mpGrKO7zPNakv
	Bx877JGF0hiREMeGVjpE8rZg/XT+StqNYrRW8ig+D9P+TFHPvZ9RzYkLS/oP4MNLObUtHjsZn8k
	qLIbLFLfUqnmSBkh/D78bNOdgwACB4hSV3gavxHaE24VsbYxhlF/T60QBXQ9TCMrh4Roh6bKFn7
	uFwRmCzM6f31yPDl8TzcewUu6O6VAByLt8/sXi66Ke4PuIlgpo7e52C0Bp6XwDzMGO
X-Received: by 2002:a2e:b992:0:b0:385:d0af:f05e with SMTP id 38308e7fff4ca-389ff34ecbbmr63230501fa.31.1772493831510;
        Mon, 02 Mar 2026 15:23:51 -0800 (PST)
Received: from [192.168.2.178] (109-252-156-195.dynamic.spd-mgts.ru. [109.252.156.195])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a123573d69sm189012e87.70.2026.03.02.15.23.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 15:23:51 -0800 (PST)
Message-ID: <4b98421a-9e64-48cb-9726-ff34a5b9cc76@gmail.com>
Date: Tue, 3 Mar 2026 02:23:49 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] devfreq: tegra30-devfreq: add support for Tegra114
To: Svyatoslav Ryhel <clamor95@gmail.com>,
 MyungJoo Ham <myungjoo.ham@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Mikko Perttunen <mperttunen@nvidia.com>
Cc: linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260126185423.77786-1-clamor95@gmail.com>
 <20260126185423.77786-2-clamor95@gmail.com>
Content-Language: en-US
From: Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <20260126185423.77786-2-clamor95@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CD9DF1E691D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43462-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,samsung.com,nvidia.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[digetx@gmail.com,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:email]
X-Rspamd-Action: no action

26.01.2026 21:54, Svyatoslav Ryhel пишет:
> Lets add Tegra114 support to activity monitor device as a preparation to
> upcoming EMC controller support.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>  drivers/devfreq/tegra30-devfreq.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
> index 8ea5b482bfb3..fa83480a923f 100644
> --- a/drivers/devfreq/tegra30-devfreq.c
> +++ b/drivers/devfreq/tegra30-devfreq.c
> @@ -963,16 +963,22 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +/*
> + * The activity counter is incremented every 256 memory transactions. However,
> + * the number of clock cycles required for each transaction varies across
> + * different SoC generations. For instance, a single transaction takes 2 EMC
> + * clocks on Tegra30, 1 EMC clock on Tegra114, and 4 EMC clocks on Tegra124.
> + */
>  static const struct tegra_devfreq_soc_data tegra124_soc = {
>  	.configs = tegra124_device_configs,
> -
> -	/*
> -	 * Activity counter is incremented every 256 memory transactions,
> -	 * and each transaction takes 4 EMC clocks.
> -	 */
>  	.count_weight = 4 * 256,
>  };
>  
> +static const struct tegra_devfreq_soc_data tegra114_soc = {
> +	.configs = tegra124_device_configs,
> +	.count_weight = 256,
> +};
> +
>  static const struct tegra_devfreq_soc_data tegra30_soc = {
>  	.configs = tegra30_device_configs,
>  	.count_weight = 2 * 256,
> @@ -980,6 +986,7 @@ static const struct tegra_devfreq_soc_data tegra30_soc = {
>  
>  static const struct of_device_id tegra_devfreq_of_match[] = {
>  	{ .compatible = "nvidia,tegra30-actmon",  .data = &tegra30_soc, },
> +	{ .compatible = "nvidia,tegra114-actmon", .data = &tegra114_soc, },
>  	{ .compatible = "nvidia,tegra124-actmon", .data = &tegra124_soc, },
>  	{ },
>  };

Acked-by: Dmitry Osipenko <digetx@gmail.com>



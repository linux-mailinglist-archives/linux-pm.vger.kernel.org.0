Return-Path: <linux-pm+bounces-2534-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21DAF838720
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jan 2024 07:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F5911C22FA2
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jan 2024 06:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182D94EB5C;
	Tue, 23 Jan 2024 06:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cNRO6RFu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACC84EB44
	for <linux-pm@vger.kernel.org>; Tue, 23 Jan 2024 06:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705990197; cv=none; b=gI566S/Rqj09Zhh2dnBznuyjxArR6IPZ8iEXpZu7vr3f7oBvLwdHHhfnHHRQzfDQZ5mN8Ad7xnElcI9vktuJZ0Gn1x0AvNDY47osMenjHV0t5hq5PyIdtfaBou5KMH6f2FA1Wy2vDQmbKNEwkO1C2o6a6zlRFgnsPtnlPsMIbJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705990197; c=relaxed/simple;
	bh=fICYgU/e513dmMdbagqrvMAVnM53SUgfbQwsBjy+Yos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l9Q/CLA0vA/znZIPMElZxoEWv7MykCoC8bzDL5/mZE2Z8cqiI81gcV6Lu6sM96NiN9rzCQCvHLXOkGGc0v8jrMl/AIv/K6wUfaDCstXqAlr5WDs7BzOW/jIJ/cNoIosMtJz89U50SsDxQ1yVyigO3+KpsEgRDUoF8Hy3uQ6aka4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cNRO6RFu; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5993047a708so1987468eaf.3
        for <linux-pm@vger.kernel.org>; Mon, 22 Jan 2024 22:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705990194; x=1706594994; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gH5uJ9kMxbNgHS2YfX23GkOHBxHF1R2S8Ddt4Z+/Q6A=;
        b=cNRO6RFujdUoG9tD0smiK15hLZ5J3zS5hkUPx9zzpf2ZLUiRvk8qTCUFzU7dWDuAhT
         3a3ovEpoYJ9/AlNO6b3XBxm37W3zlMQqFV9HKMhMsx9Gx4S+SPgTeL9J+ADGdm0e++fV
         YzQRt/q7J3eb5GPwkYaK+dYlf5QiAr3WxSIL4ddFa80sBHuuqYuXpzkjHLcIUfuCMsb3
         EZ5/TqaQ4li3PZ51ZrMs5Vu8gjw7YQBd+kQrL60NYmDFG1z6idhYHtKz5zJnMEk0W1Ye
         /nxGUKaLWvvo9ZckZMx1WZ9vX2TudRik1KfnLMcSGUiZq+QUczLKQ+qjyj4EyZXkuA7E
         Kstw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705990194; x=1706594994;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gH5uJ9kMxbNgHS2YfX23GkOHBxHF1R2S8Ddt4Z+/Q6A=;
        b=suj41exqxa30cW4wUDYPCYU9CT3xp6e79USBJh7lZ795TPLAQ917zkNFhLcIr8iKZ6
         gxGupekF1tDThaZXEfOg5vtbKWhLc+XFgzthNksDeggJOtJVU2RcHoVxdmnDY9Zj9uWb
         hS1FCnWH9h7miEaI3yZgxwb1vkgyX4mQBjsCsE7a475fqbWIACgSkVvWJdtrtD7sc5A4
         k5OR8SlhClyTC67m0JG0HRxwaEplpCEGmYcF9IngQQNLjIRxXRYYfHAxNp2g0oC4MRq0
         VTd5PLwK4In9DR9Z778n3mosLhRli3kYiQEQGxP5z+sRh+/5YhIgJT7BtjVQMICRXBTP
         g6TQ==
X-Gm-Message-State: AOJu0YxLTn1phw5NI0sSltg7gTwH9ON9Qw4pgBxgLomm/2jtxlAtlBgC
	XLTWP8vVGEgT/0vPTaID85HQvtRz2oQN3oKmTPl9XLAHoCh6GwnpbhT3jWoQYsQ=
X-Google-Smtp-Source: AGHT+IEa6u4y25PmtAOJIzMLZ7kuLsaH6aiw8FXp0uievkuh4/VBS03zIAsrfkYHzALHuHoy/WXCXA==
X-Received: by 2002:a05:6358:281a:b0:174:f664:e477 with SMTP id k26-20020a056358281a00b00174f664e477mr5037598rwb.60.1705990194606;
        Mon, 22 Jan 2024 22:09:54 -0800 (PST)
Received: from localhost ([122.172.81.83])
        by smtp.gmail.com with ESMTPSA id s4-20020a62e704000000b006dbd59c126fsm4198271pfh.11.2024.01.22.22.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 22:09:53 -0800 (PST)
Date: Tue, 23 Jan 2024 11:39:51 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>, kernel@collabora.com,
	"Hector.Yuan" <hector.yuan@mediatek.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 2/2] cpufreq: mediatek-hw: Wait for CPU supplies
 before probing
Message-ID: <20240123060951.2m6h6t537bu27ois@vireshk-i7>
References: <20240110142305.755367-1-nfraprado@collabora.com>
 <20240110142305.755367-3-nfraprado@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240110142305.755367-3-nfraprado@collabora.com>

On 10-01-24, 11:23, Nícolas F. R. A. Prado wrote:
> Before proceeding with the probe and enabling frequency scaling for the
> CPUs, make sure that all supplies feeding the CPUs have probed.
> 
> This fixes an issue observed on MT8195-Tomato where if the
> mediatek-cpufreq-hw driver enabled the hardware (by writing to
> REG_FREQ_ENABLE) before the SPMI controller driver (spmi-mtk-pmif),
> behind which lies the big CPU supply, probed the platform would hang
> shortly after with "rcu: INFO: rcu_preempt detected stalls on
> CPUs/tasks" being printed in the log.
> 
> Fixes: 4855e26bcf4d ("cpufreq: mediatek-hw: Add support for CPUFREQ HW")
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Applied 2/2. Thanks.

-- 
viresh


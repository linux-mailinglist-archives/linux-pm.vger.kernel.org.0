Return-Path: <linux-pm+bounces-2018-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF659828B38
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jan 2024 18:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11DBD1C2469B
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jan 2024 17:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3ACB3B781;
	Tue,  9 Jan 2024 17:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ECGrqQF1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05CE3A1C2
	for <linux-pm@vger.kernel.org>; Tue,  9 Jan 2024 17:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3368abe1093so2810289f8f.2
        for <linux-pm@vger.kernel.org>; Tue, 09 Jan 2024 09:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704821297; x=1705426097; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DXaCpLG4C/ir7DMFvPPuoa81dZws9KWt5H7TfSWS/y0=;
        b=ECGrqQF1KJr3LTTpMA2NNM8sxfg8crw66wevT0JHAzMg82YD7n6xodhkQje+lInNxs
         I4OZu/vojJEfhUpfJH34aB9MJezk0k5TGy76FvmlFyj84jxNgBqs72/RUTP/cW+AmdHz
         DD26Jh3X+2TTY0XT7cIx8yWl/zyWGe1DpH4KeqXdxQuThyt7dl2r+xCihpa1XVYhmj6B
         i1dganvo40Pmf14sS1dfEKwYFHikHFglLRAu5km5gti8JgACA2MzBrfYqVp7vYNdLYKg
         6REZC1Cgq6ROe584CNWJ5C8e6m+/tCBJ302eg1WzzDeZnBQotFOzpKIFiIPUTA39m9vG
         32rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704821297; x=1705426097;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DXaCpLG4C/ir7DMFvPPuoa81dZws9KWt5H7TfSWS/y0=;
        b=Cc4JKrMH5u3aCpURSPnY1/Uc61lAlfInUm6cAa52fpVUuIX/hXkYWfRHvOiQyp7Vyq
         wvVUAvFRSJLzSlyI6wNfbsZ9Lo+dy/hgjupOH1qhbCZ4pr+d0tlOW8WWL7+2/NPkx3P3
         xxGw8EIHcUMvA9y+B0cFLifq3LxZMfmJw4b9Zv66eeMDjvn4Jm6dz7V2kI+EAfMoBWr6
         88ly0AjHnSvtIlcS1CPU3CGa2NYJO4ShUxWg04d3hAGzSxGGgVEnl1BdzHBIUXdJ2TfD
         WsT5+prnOB8RIYL0rbdsIctAAopd1YHvWp+ql25n4S8OsljKsVPn3BreWPBsty8pmyYn
         6cMQ==
X-Gm-Message-State: AOJu0YyLbaPmOwE05ruZIq+P2bq3oavxf9TdHt7CTBoLcHNIiQ4en3fg
	7oTrk7Mv+GFtTS1lxFMlRjTeX3QK6tXQ5g==
X-Google-Smtp-Source: AGHT+IFLN+7RV3EiLl0Z1OfLk39i3z4WHFOSoCEhE33KW/bbX7Y29yn64IyPPF+yuDKtY220Fq59tQ==
X-Received: by 2002:a05:6000:1943:b0:337:4c69:3ec3 with SMTP id e3-20020a056000194300b003374c693ec3mr792595wry.32.1704821297195;
        Tue, 09 Jan 2024 09:28:17 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id df8-20020a5d5b88000000b003376d4248a9sm2908868wrb.71.2024.01.09.09.28.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 09:28:16 -0800 (PST)
Message-ID: <c8812a7c-47f2-4d05-9c4b-2167e77bd625@linaro.org>
Date: Tue, 9 Jan 2024 18:28:16 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] thermal: netlink: Rework notify API for cooling
 devices
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, LKML <linux-kernel@vger.kernel.org>,
 Lukasz Luba <lukasz.luba@arm.com>
References: <2193991.irdbgypaU6@kreacher> <3293702.aeNJFYEL58@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <3293702.aeNJFYEL58@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09/01/2024 17:42, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> In analogy with some previous thermal netlink API changes, redefine
> thermal_notify_cdev_state_update(), thermal_notify_cdev_add() and
> thermal_notify_cdev_delete() to take a const cdev pointer as their
> first argument and let them extract the requisite information from
> there by themselves.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>


Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog



Return-Path: <linux-pm+bounces-16299-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC4F9AC849
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2024 12:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F4F6B20DE7
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2024 10:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A2419E997;
	Wed, 23 Oct 2024 10:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ygTJzGxX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66191BDDF
	for <linux-pm@vger.kernel.org>; Wed, 23 Oct 2024 10:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729680915; cv=none; b=S5Lk3bPg5fhCEidsXLKG/2zDA/mkhprLJ8iP1xjxoTvyJn97h5h9T5ST7/8UhjQf3BmHp1tPq5Og8jWA5PdnEWrn6JSdHSGEA9u7yecBD0UpHGY1Ch4loVrI3HrmfZmsFwO+182YNz7qS/wiJlQ8WSp7BuUMZ0rL9eO+ja6Eb5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729680915; c=relaxed/simple;
	bh=PYSYk4yChI/qEElL0mhKhEWadta5YTV0S+UatC3rpi4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=efg7MVhOYaemUsj8AbJ6irISElF+TJl1wE7x2+9/FFN4FGpMsbxgeRF/ELy8e62t9vy3qFo0oUrHe35TBftDXWQK02AR2QZbFmO2uc/PG2+ungKS7ES7vAocnNG2AViR1uHyb9ipf3xvLldFnjPPoG2KBUHo6dR4utpIY0VBfXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ygTJzGxX; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43152b79d25so64739135e9.1
        for <linux-pm@vger.kernel.org>; Wed, 23 Oct 2024 03:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729680912; x=1730285712; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uYP2IdINwmVsZFFYY/g96PDfrhV7wqOC1MiqeoXEQgw=;
        b=ygTJzGxXaej0aM72lQMsaRnFvlT+C8iqHZuh4ZYcY13RNfSM2mcuf/t2qfMc0Lbz5O
         WplymEAnwKmZXmQjU8svIPaidxTjKBa4CF6Rp0k4Eyj5v+3KH30zdLKMj3Rtoazmeao8
         e34w05eodSa3Ax6jXPOBooNYwjSFuUixnQydWBAB3SwfewyR9BxoHhQd300L2FQyX0VJ
         yS6JJhy9r4lLCGuU7uJ7WMY2mDzzcdXHCE5WFoADxo31FFSZPrx1ktTOK+IiyPdR9sv/
         PcQ7LTjyFFG3Ldo+RASuAW3pt5YVMiAal97B539YlnQtar5tsd61ov4E0oUpI37VA3NY
         asWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729680912; x=1730285712;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uYP2IdINwmVsZFFYY/g96PDfrhV7wqOC1MiqeoXEQgw=;
        b=WA9zuOQ/VOVSAJ5i1LXTE2RwlrXKC6KFk9fwZRJUVs6FoS1iaJdwNKpNv8sOcUpOWG
         +HX6spY4jTnmo8a36zUnAse+r0oUFntyjdn0y6PF5gaDFoKyI9Jips8Jw1ww2toC5qel
         cWMVugkmKiPhEEcTMp9YaDA8Xc51knNiE9RDOn1rdq/H8cgxq86ogUrK9CqFneVjYqUC
         8HA+dXQpf4b3VC6g4LmlSeJF4bwquJCuoEqoapiCXGPBc1EBtdCLGBkhXdHS/K4NfqqZ
         k9IUQ2fpaAG1ixTBsqaYkf80UIOkQY4N1f2uMzNZMErFLLbfEwgEvLoXsF4zWab/m+EF
         5dmw==
X-Gm-Message-State: AOJu0Yx+piStTKXfZBbMkBxAVixZZCRuIzShP7Q8JHALstI895BDRRKn
	QN6y/h8x//kPPDlRr+BrzRlGfV+Je0d59gRcY5p9rJhDdbIPxEPyQDZMPy3TiYM=
X-Google-Smtp-Source: AGHT+IEBNQZP1PxjV1NMvGVUmn+dY7SIwGNBgeIYhlEAB7T55Fb4trH5hVY0+xBbrla6ZGWENVyr5A==
X-Received: by 2002:a05:600c:510a:b0:42c:bb96:340e with SMTP id 5b1f17b1804b1-431841a2ebbmr17169145e9.31.1729680912116;
        Wed, 23 Oct 2024 03:55:12 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43186bfb6bfsm12916975e9.23.2024.10.23.03.55.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 03:55:11 -0700 (PDT)
Message-ID: <d2bbaab5-399f-4cf4-9e50-1cb270020ab6@linaro.org>
Date: Wed, 23 Oct 2024 12:55:10 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/5] Add thermal user thresholds support
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org, quic_manafm@quicinc.com, lukasz.luba@arm.com
References: <20241022155147.463475-1-daniel.lezcano@linaro.org>
 <854974d9-fc56-4a40-977c-9ce90b783338@linaro.org>
 <CAJZ5v0i4K5BFUWcZFfyR=AFwdAGfuEEKu-EK_vRH4NTSPP=iUg@mail.gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0i4K5BFUWcZFfyR=AFwdAGfuEEKu-EK_vRH4NTSPP=iUg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Great thanks !

On 23/10/2024 12:31, Rafael J. Wysocki wrote:
> On Tue, Oct 22, 2024 at 5:54 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>>
>> Please note, I did not fixed the locking issue assuming it will be fixed
>> when the series is applied as stated in v5.
> 
> Yes.
> 
> Applied now.  Note that I have skipped patch [1/5] because it has been
> applied already before.
> 
> It is on my bleeding-edge branch ATM since the commit IDs may still change.
> 
>> As soon as the series is merged, I will send a couple of changes, one to
>> fix the memory leak and the other one to fix the warning reported by syszbot
> 
> It should get to linux-next and thermal in a couple of days.
> 
> Thanks!


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


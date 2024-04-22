Return-Path: <linux-pm+bounces-6794-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC378ACBBF
	for <lists+linux-pm@lfdr.de>; Mon, 22 Apr 2024 13:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D66EF1F24257
	for <lists+linux-pm@lfdr.de>; Mon, 22 Apr 2024 11:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6BFA14659B;
	Mon, 22 Apr 2024 11:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RV5atbym"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69431145FFF
	for <linux-pm@vger.kernel.org>; Mon, 22 Apr 2024 11:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713784416; cv=none; b=YKRWg1/NqhgDOvp0xcOreY5RdF9ycCdmytCMoIpWaEF7M6xFTaKTRt5t3A4vcQ31+4EX0NlG4gzvA1YUtt42Y0RIMLYzJE8IsAzbW6i211PMr3RNNGIprKCpGVafOzYzjA2EgYxokBB7XVIBD3kTT1twLWjQriiqJDGav3FLC0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713784416; c=relaxed/simple;
	bh=gf1LSfks/DZu1KDGH9YWvHY5EzI1fuwlgU++9PgdGiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jq79ry1lwD41oGcPgOIKMcCDj+jsxUxX/eqk+Dr6BjXjaxjODp0iIW+jW/rympPoV4CnB7Nr/wc67a7oCXJ4U3Ma38PcpzBI53+4Go0j4vnSNxMJMv8XygzrpDN9mpDtFZnX0Y3CAkCYUy33ALyiWFkPJChyKZlIjtz4RY01Bfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RV5atbym; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-344047ac7e4so3082155f8f.0
        for <linux-pm@vger.kernel.org>; Mon, 22 Apr 2024 04:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713784413; x=1714389213; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CzoM1x8KJ7efkIkmfaAcVKjjXVwNSzB4dxxASXuEBKw=;
        b=RV5atbymdvPdnVTe3Sg/5pmOTEzsOZ3I2J3JKSWht745V2NfXKCueu1WioOlaQp6jc
         N7HJcfUEBB2RM6bXmbDg5AHrBRiQXfZUshioXI8JfiHQqc6veP7EcTHzA8E6ZeASeLxA
         9i+ye3w6sK7w3OMcLLDWy+ugSCkHprv3Kq9SJuDH3d14yetUvSIhy/IoqyKJFUeC6HA2
         BKT34BhvLuwyMYxL8o9zxfol9NrlrHPlDEl/SUGv4EgqQ3SUxmZIRTqzazqcq2GVLXPr
         IAxuv2L1UXE3VUwv9E9fSqqprIfccQrmQfqVhwp60++XNco8L8Nhb8tEiF8cZFKa8Mv/
         3+CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713784413; x=1714389213;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CzoM1x8KJ7efkIkmfaAcVKjjXVwNSzB4dxxASXuEBKw=;
        b=ng3nQtNszYsVn4Wkld7+03ATcbFwDlO4Fc8p024G6/cf+DWmTuj8O16OyYYk0YWPT6
         tDWNmBhd8zZNtejRjEvtV39BoCaYxao0OHTUiXkxJcs0fDvsVz68/JzBK+iF0Neygylz
         m7wYLhBD1PTZpnaXWY4DyTnZytOojoAXemDvyl7OoVCbji11cEysljPbkHs+3w/Z8LoA
         OM7MzWO7viI9CA6SCUkUm2cCL7ZtJn3Av/zD20QS9BdIKqEKz5EMD0l9ODNxcecGdwqc
         DP8f48Ujz3AMg70CEl6ZCjiulaN36CKFQsKFkC+EH8E/zEZalzcpP6H04Da4p2FfLCPB
         WVyA==
X-Forwarded-Encrypted: i=1; AJvYcCU6FNNfhC+hpWs2NIQvS+lAV9nmHDylRfa+eulvwYNucU6EkrYz4WFfeWa4DjGd5mXkEYU0QTHsRdIAFSi31BHaSS5Zs/1yks4=
X-Gm-Message-State: AOJu0YwAX44SBudnuxe9uYlXU+ZxfTbqCiLbJeGC1RfbKdUNDQxASVhK
	fOpdQsby0L1iEzW8GvOZaemPHL4RGT1xvbbk3Td67MQaCRfb6WqwbHJ43VD0nHc=
X-Google-Smtp-Source: AGHT+IEOp5Z7JHtY8l4UoPuY/jR6T3IYDex/kZU1e2WpLFswrPJSHkIzZhdC+1o76Ax2K18wmbbOfQ==
X-Received: by 2002:a5d:4083:0:b0:349:bb17:6e60 with SMTP id o3-20020a5d4083000000b00349bb176e60mr9370805wrp.2.1713784412724;
        Mon, 22 Apr 2024 04:13:32 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id b4-20020a5d6344000000b00347363b77dasm11684546wrw.33.2024.04.22.04.13.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 04:13:32 -0700 (PDT)
Message-ID: <3f42fdb9-044f-460b-8701-7a95f9d5e638@linaro.org>
Date: Mon, 22 Apr 2024 13:13:31 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] thermal/debugfs: Make tze_seq_show() skip invalid
 trips and trips with no stats
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba
 <lukasz.luba@arm.com>, LKML <linux-kernel@vger.kernel.org>
References: <2727917.mvXUDI8C0e@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <2727917.mvXUDI8C0e@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17/04/2024 17:51, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Currently, tze_seq_show() output includes all of the trips in the zone
> except for critical ones, including invalid trips and trips with no stats
> which is confusing.
> 
> Make it skip the trips for which there is not mitigation information.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog



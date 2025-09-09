Return-Path: <linux-pm+bounces-34221-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5EE5B4A5F7
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 10:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E7707B020E
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 08:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1EB2727E6;
	Tue,  9 Sep 2025 08:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MbilZubL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BF3262FC5
	for <linux-pm@vger.kernel.org>; Tue,  9 Sep 2025 08:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757407888; cv=none; b=XRubJ0a62qoruUA8Ehxzj/eL1n1XvJxjGnt8TDxoioojaM+VlqYlEeCQDlIKOJKP9418ggjufq1kVKSCm42q6afCr40/dtQ5IyLJi3x+Skh8XIxBjStfUtDqB7ihAQ8EdmeDPq+Z4XUtqz7zK+ighhv+BpYFGdYEF2wsaUR2vgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757407888; c=relaxed/simple;
	bh=1i0l57ZqPs+nmk+dFWLjTwKNbcYbY5vaJfjBDNvQmEA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lNwrwthIdO4+ErhRCLN9wqyKfRlobMK9Qj71lynGaInVHS1oBJYJmo7MnM7ViRqgldkWswa46H480SelZg0494nIdea/EwvU9Ow0CkC3OpIlZW234ryKY3QtHaDVMwfBPB2j22YKxucvAab1EQlwBwUi+ICYDnkNJHzTAtNzG00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MbilZubL; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45dd7b15a64so34539305e9.0
        for <linux-pm@vger.kernel.org>; Tue, 09 Sep 2025 01:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757407885; x=1758012685; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4BbK4pmT6bYfsuRclAv9tGmENtdvKapeB1KD4zENnxo=;
        b=MbilZubLP8HGIcUYPayibK3NA2+OCRapfMPZaS3RVouAoOaJ8JYAVT2UiLD/cEBlXp
         fDqwboQaAWIeZmuCvl8rN8qnVEwfpJkHm9FD+t0my01NFD0zHDLmvJXTFbkCtzwROlFL
         rYNp/3GA/cwaloArqKEX4MUuiviKkzPpNlu5Ej8nFNmZxLqvKFHOF8zoHBqAcP1FBRHv
         HLaGpXPtxT5/cXGLu5c+otnFFHooj4uCPaWrIz3739vY62Hxm5+lD73xO/8+WiaZEDB9
         ycgqoKLbrVl1bEyCiZ4dFdRWrls/ZsXT953ASXCdnlU3QgXcG2yz/B69zB7J8xAuicIv
         ePJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757407885; x=1758012685;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4BbK4pmT6bYfsuRclAv9tGmENtdvKapeB1KD4zENnxo=;
        b=ad502Y7G/rWFWKMfnATgDaothD9T4Ptn4So0yGzIhUgZiGHAh7jKcJg3kWyShIcJoT
         bQvFgCd5v2Ub5cr9IZaxolQXMEEZDPgBRVf2w6QG/co6MelLgzihA7H+coNZofvbBBIL
         E8GT9TQQm+efF1xlzNJol0YnhOphdUUATXcHU8vN+B28EQ4IUsaJqHiGqWhpKgbNNx7D
         JhBbhWXpXqTN7H7v+kO458+f76/4l8zuNnBoA7UXaiDLGuNblms7cZxHIy9cQEGa/8YI
         Wfmn24iD2es6Ut/SyfC+7O+511HQWxPPNIHvdm+j+A4lW7Ww0yjNffTKv8Sxid33pCpF
         DAKg==
X-Forwarded-Encrypted: i=1; AJvYcCUIiOFGNsW1QXTicpLhN2dNuxrQGSci/xXY0u1y+70D0SqxHS3Bw730+PVmkpOwVNYhYlEfC/kIIA==@vger.kernel.org
X-Gm-Message-State: AOJu0YymqDnzL2HK6laYrafclY/EAWVVg1NiOSsePquyRhS3fiMJTUyr
	plMY7PYAXKg9o7LHI73lqjE214d5M1HzX69UGzjFZ9rLKvgQfwmcCSQMUvwK4uP8Ejl23iakEtI
	ERaLl
X-Gm-Gg: ASbGncuiIECywwFyzhe1GVJRmqXkDOG1dRecy0ifZy17f1CZOsWgtWbj934eK2iAcTU
	0FJRbpxGMdvLHesuVnyeeShZ8UkuJuq5cY0rrDjI8vgP9LrJI0Nau/kkKqJ6esyZoIz3/z0hFHI
	yMcXwxgxAvDZNcaeBRSuPbV6dXaXmWiDNyGYqxYFXQzx6cs3TuZOjAAUslWfO/i6YjePrd1C3cv
	C+trKjyOcbEo/8VQusKkZarqd72cKBJP/bW2yQxKgy7h6GDuhGAgRR4f3Atgi5Hsucr2vBpehrG
	XSP+sXTpjyw25B6p/4zmp8Vqc3oVTfPLiXJvOlNUaefUU9kek5bl6tmlKAUAFBkRnRkKod5VaF6
	fxiwgwjKbu9QMv1VmEbhnjbRbM+hc0f4PSGLIrNwKLL6BcWp9TztttjJOqzDGzOygbCaW1bQKVc
	J3
X-Google-Smtp-Source: AGHT+IGL8x6BwFXjJDJUYELQJ29ZWMfUnWO7dg/5uItdRfaodfdZ4YFnPkvyFInGau3LOLm3pLE8/g==
X-Received: by 2002:a05:600c:4746:b0:45c:b642:87a6 with SMTP id 5b1f17b1804b1-45dd5aa03ccmr137829465e9.0.1757407884865;
        Tue, 09 Sep 2025 01:51:24 -0700 (PDT)
Received: from ?IPV6:2001:a61:13f5:7601:eee5:15cd:c3c1:e601? ([2001:a61:13f5:7601:eee5:15cd:c3c1:e601])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e75223f607sm1727954f8f.51.2025.09.09.01.51.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 01:51:24 -0700 (PDT)
Message-ID: <30807256-d5f4-4550-8e1d-aedee05dc667@suse.com>
Date: Tue, 9 Sep 2025 10:51:21 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Different approaches to sync timeout: Desktop vs Mobile use cases
To: tuhaowen <tuhaowen@uniontech.com>, pavel@kernel.org, rafael@kernel.org
Cc: saravanak@google.com, huangbibo@uniontech.com, len.brown@intel.com,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, wusamuel@google.com
References: <CAGETcx-mA1kBw+r+tJOdpdqKHZQfNHvA-JS8wXc_ZHhj23WtMg@mail.gmail.com>
 <20250909071358.5943-1-tuhaowen@uniontech.com>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20250909071358.5943-1-tuhaowen@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 09.09.25 09:13, tuhaowen wrote:

> **Use Case**: Desktop/laptop systems where users expect immediate feedback
> **Problem**: When large file operations are in progress (e.g., copying
> files to USB drives) and users initiate suspend, ksys_sync() can hang

It seems to me like both your approaches seek to mitigate
the consequences of the issue rather than solve it.
Your issue is that you have too many dirty blocks associated
with a slow device.

In other words, you should sync and need to limit the number
of dirty blocks created after you've started syncing without
freezing all of user space.

	Regards
		Oliver



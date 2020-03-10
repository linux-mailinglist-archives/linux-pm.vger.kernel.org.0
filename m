Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5E3717FC6F
	for <lists+linux-pm@lfdr.de>; Tue, 10 Mar 2020 14:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731260AbgCJNVF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Mar 2020 09:21:05 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42970 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728891AbgCJNVE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Mar 2020 09:21:04 -0400
Received: by mail-lf1-f66.google.com with SMTP id t21so10839608lfe.9;
        Tue, 10 Mar 2020 06:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eCOf6OlvnGPo1hdNSLTHBdAdbBO34t+xIqKTSfU9Lvs=;
        b=ofGge65itC/lwthulFPkeKmDbr51QadcYAHtbQTWHLMr4RdA4qAd/052klcqj2lAsG
         lG19xD5JLaz+SSBvbyWBnexIZXc+pMAmdLEy/8T0gU/LQSksodQR33+THK0q9M2snw2N
         GCSwTKPgt0loPawbXIl8cFRjEWNxE1H1gbIf4NsO213jri589TnigSRklTK61xdOj60u
         Vz17OG0RXYAJKvJx4S+NNYBKhIlvGutiLYN5BEW6S2OfLzQwh6t822l/YxOgLNhAGHhB
         AGa1bkaG9PycUT/K+Jw38gw8R06DQVD5zMnrU5+OTuVhu7qk3UDW2PX9DhrNMn4pNvXK
         3A6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eCOf6OlvnGPo1hdNSLTHBdAdbBO34t+xIqKTSfU9Lvs=;
        b=SedNbbYY7eEz2PvpOv+31uzHZYbA0nfTUc07HdlNyzilL/VOOwtXYbpOmpn8yGPnyf
         Yefv+5HTNt38osYqbkwr0/7LgmCZ9q2hvoYw16wVFl9ERVaYArrPjerHBbVEk8duxke7
         A55eVc5jb8l6AxcTMIMc0Q5hgSTNAh8BA3QxX3qwgJdOPCscseox2/raOFAn7iivpIK0
         LvaUlmPrgY9/JIKqJVksqAj3ZZZs8RIV6kUNFzELzpaQnFgd2nfljC4dT26NRDXgHChN
         TvPUeinsV/YwHjya6CL3QcP1A4FagqVzoDSpsPwPlD2jlq8BpCA3Aja1gijsrgYvMsOT
         Cisw==
X-Gm-Message-State: ANhLgQ3d0wNyKGSUOpCgi44OciAOSFyZ5gnuavv3TwfNDc6MJZ1HmpL9
        +PdjenW3rtgo/jDv3xisDrY4JHEO
X-Google-Smtp-Source: ADFU+vvwQjyIsXgU6I8GX3SpR7E8fsB37sAUt5jafoxPGt96Qq9i12zZidE0qlga4HzlmkG+DA5O4w==
X-Received: by 2002:ac2:5c44:: with SMTP id s4mr9161431lfp.129.1583846462339;
        Tue, 10 Mar 2020 06:21:02 -0700 (PDT)
Received: from [192.168.2.145] (94-29-39-224.dynamic.spd-mgts.ru. [94.29.39.224])
        by smtp.googlemail.com with ESMTPSA id v17sm12992881lfn.64.2020.03.10.06.21.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2020 06:21:01 -0700 (PDT)
Subject: Re: [PATCH v1] power: supply: bq27xxx_battery: Silence deferred-probe
 error
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        "Andrew F. Davis" <afd@ti.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        David Heidelberg <david@ixit.cz>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200308215143.27823-1-digetx@gmail.com>
 <20200309230608.aur2iddomzrdw4pq@pali>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <4d0cb298-f6ab-731d-a5d9-e08ed092f504@gmail.com>
Date:   Tue, 10 Mar 2020 16:21:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200309230608.aur2iddomzrdw4pq@pali>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

10.03.2020 02:06, Pali Rohár пишет:
> On Monday 09 March 2020 00:51:43 Dmitry Osipenko wrote:
>> The driver fails to probe with -EPROBE_DEFER if battery's power supply
>> (charger driver) isn't ready yet and this results in a bit noisy error
>> message in KMSG during kernel's boot up. Let's silence the harmless
>> error message.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> 
> Hello Dmitry! This change make sense, it is really not an error when
> bq27k device registration is deferred. You can add my:
> 
> Reviewed-by: Pali Rohár <pali@kernel.org>

Thank you and Andrew for taking a look at this patch!

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1228315A848
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2020 12:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbgBLLu6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Feb 2020 06:50:58 -0500
Received: from mail-pf1-f172.google.com ([209.85.210.172]:41212 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbgBLLu6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Feb 2020 06:50:58 -0500
Received: by mail-pf1-f172.google.com with SMTP id j9so1122930pfa.8
        for <linux-pm@vger.kernel.org>; Wed, 12 Feb 2020 03:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SNJguF6fXZBD64srEgTMtsMKvmaYnTcmUx5yaV0STFc=;
        b=f+xis38Uz6BT0DmvvXp+IvwfnKh6g1L/jH0cqofQHcDHWBACS390J+tZaAi6huv+Rh
         QJxI2p15/yVGD6TYb28+InPftcXlfQ3HDofnU3/7EIi3hGVG2rwTINrxiLyFzUDZ3EEr
         VK1uvyedHpX3RgVhzHK+tyo2OLqlRTF1/YQn0k+0khY93GzClfj38QEQAg83FcPrf+gA
         jNIaT8xLFdv41K2N7FdYXBtP7zisW/09fQH6iJZG9tC4sPXz9JQ0V/+GIhIpfobz6Mk3
         zsNArCtKsDxKF7cXNh3ic6RdrXF/PZtTuYU455vFNrb430A4sv+WMdaGtAuE4p6fm+1+
         qs1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SNJguF6fXZBD64srEgTMtsMKvmaYnTcmUx5yaV0STFc=;
        b=UGcRkqAXh6dXH1/xAzoAeH57bL9615f4NhKdP982nziVHGc+NIg3uR01LEsqAbdwoM
         2sowqdV2HVpj07lLT53qHFf2achddZ8dUpRKKTpXrRigSQAMey6RUemBPcAKiMpEK5eS
         O1VbqgRSSX4/L6bfbIYc5+rv8R6GBvTJiYJ6JEF8XUJZIXJaI/zfc8mwVGAkt5Zw1tUc
         SUecemYde1cdOTqPtby+eLFr+k3x96qyqMl/N5w7xS99WddwGCV3abQ/GYCEzeHWr76J
         uhsSql4aki8ENt5nQDJr88Kiokdwzy4oBJGRAmxnoT4a4svtEiG1rwtAeN8Haidr1eza
         OtLg==
X-Gm-Message-State: APjAAAV7GRq8Tp4yQzqR6VgY8qbgEosdJkQ3EDbeVs2Wt/H8ctDy1wCN
        rPgR7Tk1sIGpcvO1gRT5DC3Sn4hCpc8=
X-Google-Smtp-Source: APXvYqziM45BHS5NCatso9nOdPDZJApXtrAgVmVANASFFMD2orkwO0oZECtWpUO5UT3u6uxcs6d5Rw==
X-Received: by 2002:aa7:9a0b:: with SMTP id w11mr11402186pfj.4.1581508257625;
        Wed, 12 Feb 2020 03:50:57 -0800 (PST)
Received: from localhost ([122.167.210.63])
        by smtp.gmail.com with ESMTPSA id y16sm570249pfn.177.2020.02.12.03.50.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Feb 2020 03:50:56 -0800 (PST)
Date:   Wed, 12 Feb 2020 17:20:54 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Andy Tang <andy.tang@nxp.com>
Cc:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [EXT] Re: Ask for help about cpufreq issue
Message-ID: <20200212115054.eouh7e42uqlcweo3@vireshk-i7>
References: <VI1PR04MB4333D45D033CB8E33CB9070FF31C0@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <20200207052321.povhuxrlm25ueoak@vireshk-i7>
 <VI1PR04MB43334D5868037FCAE4D7631BF31C0@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <20200207070544.geurecsy4i22xpzl@vireshk-i7>
 <VI1PR04MB4333E6B3340BADBC737E9CFFF3180@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <20200211055315.qlqrxiqf72u36ijl@vireshk-i7>
 <VI1PR04MB4333D6A41BD1AB77489E3139F3180@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <20200211063439.aqc4h6np3wjpsg2j@vireshk-i7>
 <VI1PR04MB43334811F21E85BD9DACE259F31B0@VI1PR04MB4333.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR04MB43334811F21E85BD9DACE259F31B0@VI1PR04MB4333.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12-02-20, 10:11, Andy Tang wrote:
> Hi Viresh,
> 
> I have another cpufreq issue on our lx2160a platform which has 16 cores and 8 clusters.
> 
> Cpufreq works well for ondemand, performance governor. 
> But for conservative governor, even though cpu usage is almost zero, but some cpus are not
> work on the lowest frequency sometimes. It keeps bouncing from the lowest frequency
> to the other higher frequencies. 
> The defaut values are used for the tunable for conservative governor.
> In summary, why cpu doesn't work at the lowest frequency even the cpu load is almost zero?
> 
> root@lx2160ardb:/sys/devices/system/cpu# cat cpufreq/conservative/ 
> down_threshold        freq_step             ignore_nice_load      sampling_down_factor  sampling_rate         up_threshold          
> root@lx2160ardb:/sys/devices/system/cpu# cat cpufreq/conservative/*
> 20

Try increasing down_threshold to a value of 50 (i.e. we reduce
frequency if the load is below 50%) and see if it makes a difference.

I believe something is running on the CPU, that you are unaware of.
Try doing tracing to see what's going on all CPUs.

-- 
viresh

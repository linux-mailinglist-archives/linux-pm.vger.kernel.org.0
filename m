Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5272125D0
	for <lists+linux-pm@lfdr.de>; Fri,  3 May 2019 02:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfECAwz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 May 2019 20:52:55 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39426 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfECAwz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 May 2019 20:52:55 -0400
Received: by mail-lj1-f196.google.com with SMTP id q10so3869441ljc.6;
        Thu, 02 May 2019 17:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XFxxk88jKn9mWRNss+JVJf8tkKfLz3t0cGCY2rC5qdc=;
        b=OJs4rm3x3N51G50s/x0aoiLB+8fHtRv9NlRyq8fVExBdiEEYD+8LQaCT+UvG0vmTIX
         b6v8aA5qHAyKqsIOtohmEnW/3mMX1JxCP4K+KvnN6jlroPSIN3lVQfUZOBe8pefUxcOZ
         co8KG9bXdgRIbqEvDqot2Rwd/4SdQBEnsmifo7CgMpyRXq90AMU8u0qMouWDKWbLndqb
         IrHfyS7Inj/8569gubTfX0bLAIwqIlsZnJxUplGDM1oupO0+LBpMagxiFMrsAaYRX7Ix
         +2k6TE9AU/tPRJKZ+MlAHevQmSFA5YruMve4cSQ8B+uqFiFchJlf+w1HoBqPibESYwUf
         ns2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XFxxk88jKn9mWRNss+JVJf8tkKfLz3t0cGCY2rC5qdc=;
        b=MwxCtp+WXpr7HF25AvTt7XG0ZsfV1fjquUaCF3WSB9TN9KJUvE66xMR+fHlTf/XZjH
         jPwAH9R19daWep78FbUIkfYR4X0t0MyF4134ZQRM3Di06LAq4FVRpU6dd/coV59arNzC
         8wXYLUGa1MkUbSNiS53s7DcO3ZyCNKQ30G9Fixfib7FJP/TEqSde8DYXGlWVor7P8NDx
         T/G3155u5Czw5z3iSaR57pC/YLQR7j19Q0/UBtbdBwcALHv18fyIq8T0HTolo6G7RKMM
         gSWeu4OnGKXfGbP+hCxEQc9mYhVE17E50IekPuFYXR8e4xjq6LG4b7v21s+I+ByAy7mo
         +q+A==
X-Gm-Message-State: APjAAAUIV9gDANubOjCpzbHV5oWllkyyeetoYtDh2uYunk2uuOmYFG9u
        qAw6ddjEM61IOEWzk80XNyYodNWd
X-Google-Smtp-Source: APXvYqwUSY91QLyNmUPo+ija5NlVYVtyqUZqwosyNnND3zu8T7MSNFSM67fFJNrN8TIEzDGU2R119w==
X-Received: by 2002:a2e:9993:: with SMTP id w19mr3554713lji.111.1556844772675;
        Thu, 02 May 2019 17:52:52 -0700 (PDT)
Received: from [192.168.2.145] (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.googlemail.com with ESMTPSA id u1sm98805lje.29.2019.05.02.17.52.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 17:52:51 -0700 (PDT)
Subject: Re: [PATCH v4 00/16] NVIDIA Tegra devfreq improvements and Tegra20/30
 support
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <CGME20190501234148epcas5p1cc9a8dafa9ee6d8d046d1292b8270727@epcas5p1.samsung.com>
 <20190501233815.32643-1-digetx@gmail.com>
 <60ef6e47-e61b-3a92-e90d-90debedfcfc4@samsung.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <fa061a65-f108-6c5e-1f87-950a9a8caafc@gmail.com>
Date:   Fri, 3 May 2019 03:52:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <60ef6e47-e61b-3a92-e90d-90debedfcfc4@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

03.05.2019 3:31, Chanwoo Choi пишет:
> Hi Dmitry,
> 
> On 19. 5. 2. 오전 8:37, Dmitry Osipenko wrote:
>> Changelog:
>>
>> v4: Addressed all review comments that were made by Chanwoo Choi to v3:
>>
>>     - changed the driver removal order to match the probe exactly
>>     - added clarifying comment for 1/8 ratio to the Tegra20 driver
>>
>>     Chanwoo, please also note that the clk patch that should fix
>>     compilation problem that was reported the kbuild-test-robot is already
>>     applied and available in the recent linux-next.
> 
> I knew that Stephen picked up your path about clock.

Hi Chanwoo,

Okay, good. Thank you very much for reviewing this series! I assume it's
too late now for v5.2, but it should be good to go for v5.3.

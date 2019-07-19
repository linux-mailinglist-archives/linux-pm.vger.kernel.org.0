Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1C16E9DF
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2019 19:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729006AbfGSRKd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Jul 2019 13:10:33 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39387 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728475AbfGSRKd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Jul 2019 13:10:33 -0400
Received: by mail-lf1-f67.google.com with SMTP id v85so22211053lfa.6;
        Fri, 19 Jul 2019 10:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fWgRRhsX9h1WwtxrDrtscuLAp4Yc+ma/ApVSF+tdjww=;
        b=PQ8OPUCl7CkFirQUfXIbKZENbrvk5CVgSXnKMYM50COBNLSi/faCluVjC+n+PKuDDq
         QeZtBFmTRdZ3HXIGfKeLowhQqThj1NpRlu2ijgoWY872baxWL0wCtNvdsnhr5kzv/UM8
         t9+H3HX8W7mZbEnGUYrHFtGt+WeRFUvwfAKPJ6uyLnfPUItvtqO7HzJk/3pKVXzpftFT
         HHsfU3KduC7i6wiXmqCpVvaqjyEK7Aiy0ZBVO1FZ0OBmc6YwvQt09lBlTbWa6RLyxjlZ
         8ek1QBn84mamvnuoPB42PIISvlauhrhbPUBWZ/bZUz6cUkqsiu0xxklG8IjzJSOY498O
         f0KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fWgRRhsX9h1WwtxrDrtscuLAp4Yc+ma/ApVSF+tdjww=;
        b=Lik0Mp4dX+iqL/jVg3oXTVT5Ay9GKpNsCbtat7KSqCp7QXabqjJlyTT27EEAdpA/Gb
         fO75DWxo+17UiUyUU9x5bYDpJl8DopLGrWbHuA/2wT3+Y8M02xw7816BXMeP1PMg/3TA
         lwJWxV6bHpc48IV2MQiSxGNiYShq5tVjShEos7r2wl/QWPL4MtBmMz6Tj1yeCHlq3u3s
         GDZmtbpM6vZ110y3gKV9AAZ7fGvhZC5XvkLc7A7w4ufSlqg2QYzU9bJ/Ms35o0+JsvmL
         JFSFlwDqOKE1SLReDPqriD5CqtJ1obhN1oz8FlI7gb7wKaCxRmtsNmKoXJz6MRMZ35eA
         4XYw==
X-Gm-Message-State: APjAAAUM7eT3PDRuU+pYogvjRmbjZJCtqXgitYbzJSoLILossyxAEYBC
        3ry+445a6lTytSuAlKQPhLFsQnai
X-Google-Smtp-Source: APXvYqwYn5/fDwDPkv0q0vVkK3tLZANbtgW/qhlMg6hEgGdcdKuBFU/w5iKnWktkudFadxYZq70XmQ==
X-Received: by 2002:a19:5f46:: with SMTP id a6mr25477780lfj.142.1563556229977;
        Fri, 19 Jul 2019 10:10:29 -0700 (PDT)
Received: from [192.168.2.145] (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.googlemail.com with ESMTPSA id q1sm5805192ljb.87.2019.07.19.10.10.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jul 2019 10:10:29 -0700 (PDT)
Subject: Re: [PATCH v4 11/24] PM / devfreq: tegra30: Add debug messages
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190707223303.6755-1-digetx@gmail.com>
 <CGME20190707223640epcas4p15337f40466342832b731ad6a53be946e@epcas4p1.samsung.com>
 <20190707223303.6755-12-digetx@gmail.com>
 <c883bdbe-427f-35a1-9e63-5e4953a84286@samsung.com>
 <53cd0ba5-f814-cd9b-19c5-1d42717ca58c@gmail.com>
 <922c9178-71de-46ad-eafd-805af461bedb@samsung.com>
 <f819c226-4328-c85d-5da3-932391fa6747@gmail.com>
 <f630dacc-2065-a12d-bd03-1fc6c4363e1f@samsung.com>
 <20190719041357.0a80a2dc@dimatab>
 <a5e0c217-280f-a420-4604-3872a17f5c96@samsung.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <2886eeaa-f877-d0cf-7056-8cf047436903@gmail.com>
Date:   Fri, 19 Jul 2019 20:10:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <a5e0c217-280f-a420-4604-3872a17f5c96@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

19.07.2019 4:22, Chanwoo Choi пишет:
> On 19. 7. 19. 오전 10:13, Dmitry Osipenko wrote:
>> В Thu, 18 Jul 2019 18:07:05 +0900
>> Chanwoo Choi <cw00.choi@samsung.com> пишет:
>>
>>> On 19. 7. 18. 오전 12:46, Dmitry Osipenko wrote:
>>>> 17.07.2019 9:45, Chanwoo Choi пишет:  
>>>>> On 19. 7. 16. 오후 10:26, Dmitry Osipenko wrote:  
>>>>>> 16.07.2019 15:23, Chanwoo Choi пишет:  
>>>>>>> Hi Dmitry,
>>>>>>>
>>>>>>> Usually, the kernel log print for all users
>>>>>>> such as changing the frequency, fail or success.
>>>>>>>
>>>>>>> But, if the log just show the register dump,
>>>>>>> it is not useful for all users. It is just used
>>>>>>> for only specific developer.
>>>>>>>
>>>>>>> I recommend that you better to add more exception handling
>>>>>>> code on many points instead of just showing the register dump.  
>>>>>>
>>>>>> The debug messages are not users, but for developers. Yes, I
>>>>>> primarily made the debugging to be useful for myself and will be
>>>>>> happy to change the way debugging is done if there will be any
>>>>>> other active developer for this driver. The registers dump is
>>>>>> more than enough in order to understand what's going on, I don't
>>>>>> see any real need to change anything here for now.  
>>>>>
>>>>> Basically, we have to develop code and add the log for anyone.
>>>>> As you commented, even if there are no other developer, we never
>>>>> guarantee this assumption forever. And also, if added debug message
>>>>> for only you, you can add them when testing it temporarily.
>>>>>
>>>>> If you want to add the just register dump log for you,
>>>>> I can't agree. Once again, I hope that anyone understand
>>>>> the meaning of debug message as much possible as.
>>>>>  
>>>>
>>>> The registers dump should be good for everyone because it's a
>>>> self-explanatory information for anyone who is familiar with the
>>>> hardware. I don't think there is a need for anything else than what
>>>> is proposed in this patch, at least for now. I also simply don't
>>>> see any other better way to debug the state of this particular
>>>> hardware, again this logging is for the driver developers and not
>>>> for users.
>>>>
>>>> Initially, I was temporarily adding the debug messages. Now they are
>>>> pretty much mandatory for verifying that driver is working
>>>> properly. And of course the debugging messages got into the shape
>>>> of this patch after several iterations of refinements. So again, I
>>>> suppose that this should be good enough for everyone who is
>>>> familiar with the hardware. And of course I'm open to the
>>>> constructive suggestions, the debugging aid is not an ABI and could
>>>> be changed/improved at any time.
>>>>
>>>> You're suggesting to break down the debugging into several smaller
>>>> pieces, but I'm finding that as not a constructive suggestion
>>>> because the information about the full hardware state is actually
>>>> necessary for the productive debugging.
>>>>
>>>>   
>>>
>>> Sorry for that as I saie, I cannot agree this patch. In my case,
>>> I don't understand what is meaning of register dump of this patch.
>>> I knew that just register dump are useful for real developer.
>>
>> It's not only a registers dump, as you may see there is also a dump of
>> other properties like boosting value, OPPs selection and etc.
>>
>> It looks to me that you're also missing important detail that debug
>> messages are compiled out unless DEBUG is defined for the drivers
>> build. So in order to get the debug message a user shall explicitly add
>> #define DEBUG macro to the code or enable debug messages globally in
>> the kernel's config. There is also an option for dynamic debug messages
>> in the kernel, but it doesn't matter now because all these messages are
>> turned into tracepoints later in the patch #17.
> 
> 
> Right. But, this patch could not the split up between register dump and others.
> As I said repeatly, I hope to add the log that anyone can understand. 

I'm afraid that's a way too big request to make it universal for anyone
or I'm just failing to understand what you're asking for. In my opinion
it's already understandable by everybody who is really interested in
debugging of this driver. I really don't see how to make it better, in
my opinion it's already ideal.

I'll drop the debug patches from the series in the next revision and
keep them locally for now. Maybe we could get back to this later sometime.

>>
>>> If you want to show the register dump, you better to add some feature
>>> with debugfs for devfreq framework in order to read the register dump.
>>> As I knew, sound framework (alsa) has the similar feature for checking
>>> the register dump.
>>>
>>
>> The intent was to have an option for dynamic debugging of the driver and
>> initially debug messages were good enough, but then it became not enough
>> and hence the debug messages were turned into tracepoints in the patch
>> #17. Would it be acceptable to squash this patch and #17?


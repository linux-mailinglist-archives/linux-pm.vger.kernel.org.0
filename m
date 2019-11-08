Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6133BF48E4
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2019 12:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389081AbfKHL7e (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Nov 2019 06:59:34 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40270 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390670AbfKHLoI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Nov 2019 06:44:08 -0500
Received: by mail-ed1-f66.google.com with SMTP id p59so4766287edp.7
        for <linux-pm@vger.kernel.org>; Fri, 08 Nov 2019 03:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:message-id:date:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=g/++kKVU7OFaHGAtlltoncuD16PbRuMbUQv6ZhSLLII=;
        b=MQkK6jcPMk41V1f5zCzkH34OdDS4xlL7bw4LRqs5P3rbwFw8fnCjM3JmTDWj318k6e
         FREhlTnJtMiseRK9li/i2KKex9+IDrAKyUH49jSGemHMZiWeInZS/lQMgOAn2dwsFhcM
         6pyp1VxOrHReOPQT1pX26fYiRvsrjw7YtCK6JVZZYU+MpyJLWDqAdDmMOXEbxkMRHK5z
         AQUBoWqPwGjInz7Mm2JBDo2MgBqzrdh6ffacLGDm0iN4TYJ2lY+F5o0KAEuQM0fpt9/v
         2vyB0bXT+enHL6P3Up8bnfzV0dfbKDBtUQNSUWUmKO7kM6o8CHiZWLVmSKHp2yxDU6HK
         RCNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g/++kKVU7OFaHGAtlltoncuD16PbRuMbUQv6ZhSLLII=;
        b=FDfsOdb6BpCN2GbygU05FxfuSfiHcjpwIbVJNB9M2DoN1+AqVhwxA2gfcCrphWsyjf
         b0eIQl5MsmqT+qNebUWek9vm7VIe2Ez3td/KHkIyuj2NpuOeebYDeyCCerDm58oez+IK
         JyJNfYSLuqfcDmO1EVE71jZ6aTMvU6GDzICzYmtAuxQ36bu6uSDKA2BKEJG+bsTEz17G
         TFpRxzXj5br6E4g1vO7aFXjSKfcN0FCuQR65e1DyIe/mlM7d9kLo/e5eLj4zmgtcKFiD
         060tQCm1C/Tf9RDe5/eNQZu4yLSZcbvg77OyXp1et0QqlAbc+inCBstU+++maWJPQqNH
         RroA==
X-Gm-Message-State: APjAAAV+LQSJ2Pw3958MYA0QnqqHWSzS88hIgpbD7CKioVufYqLNIwdo
        wcVMbBn0p4izBvmTBdpyvy9eAS++0to=
X-Google-Smtp-Source: APXvYqy+5wkvN8ghdz9sfdp3QIcwFKW0lcB/xb+gSdB1lui68o9slbwHKbtDEd8IikQ88ubpRW95zw==
X-Received: by 2002:a17:906:278a:: with SMTP id j10mr8262538ejc.125.1573213446765;
        Fri, 08 Nov 2019 03:44:06 -0800 (PST)
Received: from [192.168.27.135] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id d11sm123025edq.39.2019.11.08.03.44.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Nov 2019 03:44:06 -0800 (PST)
Subject: Re: [GIT PULL] interconnect changes for 5.5
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <5123bf54-5d62-fc5c-8838-17bc34487d83@linaro.org>
 <20191107142111.GB109902@kroah.com>
 <0cb5a6a6-399f-99e3-dc41-50114eea4025@linaro.org>
 <20191108103917.GB683302@kroah.com>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <77e2922b-162c-5554-57f5-85ba278371fe@linaro.org>
Date:   Fri, 8 Nov 2019 13:44:05 +0200
MIME-Version: 1.0
In-Reply-To: <20191108103917.GB683302@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 8.11.19 г. 12:39 ч., Greg Kroah-Hartman wrote:
> On Thu, Nov 07, 2019 at 05:42:13PM +0200, Georgi Djakov wrote:
>> Hi Greg,
>>
>> On 11/7/19 16:21, Greg Kroah-Hartman wrote:
>>> On Thu, Nov 07, 2019 at 02:46:53PM +0200, Georgi Djakov wrote:
>>>> Hi Greg,
>>>>
>>>> This is a pull request with interconnect patches for the 5.5 merge window.
>>>> All patches have been for a while in linux-next without reported issues. The
>>>> details are in the signed tag. Please consider pulling into char-misc-next.
>>>
>>> I don't know about
>>> 0003-interconnect-Disallow-interconnect-core-to-be-built-.patch here.
>>> Shouldn't you just fix up the dependancies of subsystems that rely on
>>> this?  We are moving more and more to kernels that "just work" with
>>> everything as modules, even on arm64 systems.  So forbiding the
>>> interconnect code from being able to be built as a module does not feel
>>> good to me at all.
>>
>> Thank you for commenting on this! The initial idea was to keep everything as
>> modular as possible. The reasons behind this change is that other core
>> frameworks like cpufreq (and possibly others) want to call the interconnect
>> APIs. Some of these frameworks are built-in only and it would be easier to
>> handle dependencies if interconnect core built-in too. Now each user that
>> can be built-in has to specify in Kconfig that it depends on INTERCONNECT ||
>> !INTERCONNECT.
> 
> That's fine, when those subsystems start to use those apis, that
> dependency needs to be added.  Nothing new here, and you forcing it to
> either be "on or off" isn't going to change that.  Let's do it correctly
> please.

Alright! That matches with what we do today. Thanks for the guidance!

BR,
Georgi

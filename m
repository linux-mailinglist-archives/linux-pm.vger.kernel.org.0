Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4EFCBD633
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2019 03:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729301AbfIYBv7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Sep 2019 21:51:59 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:25314 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727329AbfIYBv7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Sep 2019 21:51:59 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190925015156epoutp0163fb451ea4a271bfeda15134f70aada8~Hi3ICGu9X1306613066epoutp017
        for <linux-pm@vger.kernel.org>; Wed, 25 Sep 2019 01:51:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190925015156epoutp0163fb451ea4a271bfeda15134f70aada8~Hi3ICGu9X1306613066epoutp017
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569376316;
        bh=SWLIQ8vr4kRyJAdxtUXf37U2nrjBb2XtX1Hc/XqZgGc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=HDoOqF6vzLdxK83oi22tUIRqC+8FrcBTIABAQLcf3GzoJJTyifXSRSSAOBJESQgko
         pZDebije59DMlKH0oUbvffOCWh4+vs66yc+qhylkNMS2nH6PM5RSRYxmW5GOjN2cGo
         CgPNVgnHX/XlcRofs0fzx7AT12KkLxALysNEjflg=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190925015156epcas1p30f6ebb41b600b9427bb2cb2f481dd74c~Hi3He2v3_3075830758epcas1p3N;
        Wed, 25 Sep 2019 01:51:56 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.156]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 46dLdj0txRzMqYkd; Wed, 25 Sep
        2019 01:51:53 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        40.46.04085.738CA8D5; Wed, 25 Sep 2019 10:51:51 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190925015151epcas1p47b1dca3057c41416eae684baed0e4131~Hi3DFlfsz2715927159epcas1p4z;
        Wed, 25 Sep 2019 01:51:51 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190925015151epsmtrp23bc528d39bd7307ff28789dc4718b288~Hi3DEtbIb2613026130epsmtrp2S;
        Wed, 25 Sep 2019 01:51:51 +0000 (GMT)
X-AuditID: b6c32a37-e19ff70000000ff5-8e-5d8ac8377697
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        81.17.03889.738CA8D5; Wed, 25 Sep 2019 10:51:51 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190925015151epsmtip186e005329bd4e927b9d23d462cc9d76c~Hi3C3szEq1157311573epsmtip1Y;
        Wed, 25 Sep 2019 01:51:51 +0000 (GMT)
Subject: Re: [PATCH v2] devfreq: Add tracepoint for frequency changes
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <418ddd67-ca8a-3d0e-066c-38d05a7082a8@samsung.com>
Date:   Wed, 25 Sep 2019 10:56:15 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190924193721.GK133864@google.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf0yMcRzH+97zo+dwPI74uFmuR4as7h7X1ZMVRbhNLIwZWh717Er3a/dc
        TfxT+XXu8mttxsUYCtlklBEVF6pNfp0fkYia+Zmt86s1m7t7mP57fd6fX9/P5/uhMOU5UkXl
        WxyC3cKbGHIEfrllpiY2sc2Vpe06lcB1VN8kuY6yz+Gcr+EIyfn33ELcoxvHZZz/Qi/iukrP
        kFyTs0eWShkqSx7ihu1NL8INX5uekIa9dTXI4L8YmUmsLUjOE/hcwa4WLDnW3HyLMYVZsjJ7
        QbY+QcvGsklcIqO28GYhhUnPyIxdlG8KvIVRF/GmwoCUyYsio5mbbLcWOgR1nlV0pDCCLddk
        S7LFibxZLLQY43Ks5jmsVjtbHwjcUJBXeuY3bvOqNp+qKcdL0LMIF5JTQMfD3Vf3cRcaQSnp
        Kwhe3nyNJGMAweD1WkIyfiB40+EOdyEqlLLjk1zSGxFc9fpIyfiK4Pn3XiJYdxy9EOrPu7Ag
        j6dnQN/Q/VBZjN4ug6edbhR0kHQMNL/vJIM8ho6CJ796Q7qCngs73/pDjNPToKrhU4gj6DUw
        0NNCSDFjof1wHx5kOc2C01cvCzJGT4QXfcf+8hTYVl+JBRsD7SehvPQZLk2dDoMfW8MlHgcf
        W+v+sgr8/Y2kxFvhbPstUkp2IqhrfkBIDh00V1XIgrvA6JlQ26CR5Ci4OnQUSY1HQ//3ckJa
        lwKcO5VSyFTw9XTLJJ4EJ3ftJvcjxjNsHM+wETzDRvD8b3Yc4TVogmATzUZBZG264d99EYUO
        NSbxCrpwL8OLaAoxoxSphCtLSfBFYrHZi4DCmPEKz+SApMjli7cIdmu2vdAkiF6kD2z7AKaK
        yLEGzt7iyGb1s3U6HRfPJuhZlpmoMBhLspS0kXcIBYJgE+z/8mSUXFWCDp9umzDf2bjVMk2t
        2VA2cGd0fG3z4qTqY0Vq/4Maje6azTjvXVFlv6YuKqu9o63pZbQ5elXivoqVRGTY426TU+c+
        6jae/rBiS/L5b50HWfmJiijUozEcWhzWql166eT0OPfkLy2RU3+uHrlsdffytN6uWdEb11dv
        8p29ve7nriFtYxqDi3k8G4PZRf4PtUqBzL4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMIsWRmVeSWpSXmKPExsWy7bCSnK75ia5Yg8snFS3OLjvIZnG26Q27
        xeVdc9gsPvceYbS4dGABk8XnDY8ZLW43rmCz2NfxgMmBw2N2w0UWj5Z9t9g93u+7yubRt2UV
        o8fnTXIBrFFcNimpOZllqUX6dglcGY0r/rIUHJKqWLKqh6WB8bpoFyMHh4SAiUTra84uRi4O
        IYHdjBL7tu1i7mLkBIpLSky7eJQZokZY4vDhYoiat4wSk78fYAepERZwldi6rgusXkRAQ+LJ
        7/OMIDazQBuTxPytfiC2kMAzRokdH31BbDYBLYn9L26wgdj8AooSV388BqvnFbCTaHv0Gcxm
        EVCVWLrrNZgtKhAhcXjHLKgaQYmTM5+wgNicAoYSHZe3MkHsUpf4M+8SM4QtLnHryXyouLxE
        89bZzBMYhWchaZ+FpGUWkpZZSFoWMLKsYpRMLSjOTc8tNiwwykst1ytOzC0uzUvXS87P3cQI
        jiotrR2MJ07EH2IU4GBU4uF1YO2KFWJNLCuuzD3EKMHBrCTCO0sGKMSbklhZlVqUH19UmpNa
        fIhRmoNFSZxXPv9YpJBAemJJanZqakFqEUyWiYNTqoHRMST1j0rIFsa2nPgMZnWG7zvs339+
        +N4o283r+51DdWu3TFzQ+/zMoTz3M52tKbpHAoI6758wmKKdP2nH+96Vants/L66tCld/SWb
        cadfoMrsRO3qTS7hakqO6eqFh1tbGe2OPs7/FZPlUnNaoedv7PPonyafVOW1Xn67K58T/enL
        otbSy5OUWIozEg21mIuKEwGY58JApgIAAA==
X-CMS-MailID: 20190925015151epcas1p47b1dca3057c41416eae684baed0e4131
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190919174436epcas4p17bf0528950813d3326237fcc56fd9b21
References: <CGME20190919174436epcas4p17bf0528950813d3326237fcc56fd9b21@epcas4p1.samsung.com>
        <20190919174423.105030-1-mka@chromium.org>
        <62b2228b-e198-2558-2afc-e5687935742b@samsung.com>
        <20190924193721.GK133864@google.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 9. 25. 오전 4:37, Matthias Kaehlcke wrote:
> On Fri, Sep 20, 2019 at 10:15:57AM +0900, Chanwoo Choi wrote:
>> Hi,
> 
> sorry for the delayed response, you message got buried in my
> mailbox.
> 
>> On 19. 9. 20. 오전 2:44, Matthias Kaehlcke wrote:
>>> Add a tracepoint for frequency changes of devfreq devices and
>>> use it.
>>>
>>> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
>>> ---
>>> (sending v2 without much delay wrt v1, since the change in devfreq
>>>  probably isn't controversial, and I'll be offline a few days)
>>>
>>> Changes in v2:
>>> - included trace_devfreq_frequency_enabled() in the condition
>>>   to avoid unnecessary evaluation when the trace point is
>>>   disabled
>>> ---
>>>  drivers/devfreq/devfreq.c      |  3 +++
>>>  include/trace/events/devfreq.h | 18 ++++++++++++++++++
>>>  2 files changed, 21 insertions(+)
>>>
>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>> index ab22bf8a12d6..e9f04dcafb01 100644
>>> --- a/drivers/devfreq/devfreq.c
>>> +++ b/drivers/devfreq/devfreq.c
>>> @@ -317,6 +317,9 @@ static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
>>>  
>>>  	devfreq->previous_freq = new_freq;
>>>  
>>> +	if (trace_devfreq_frequency_enabled() && new_freq != cur_freq)
>>> +		trace_devfreq_frequency(devfreq, new_freq);
>>
>> You can change as following without 'new_freq' variable
>> because devfreq->previous_freq is the new frequency.	
>> 	trace_devfreq_frequency(devfreq);
> 
> In general that sounds good.
> 
> devfreq essentially uses df->previous_freq as df->cur_freq, I think
> most code using it would be clearer if we renamed it accordingly.
> I'll send a separate patch for this.

Actually, according to reference time of the 'df->previous_freq',
'previous_freq' is proper or 'cur_freq is proper.
But, In the comment of 'struct devfreq',
it means the configured time as following: 
	* @previous_freq:      previously configured frequency value.
I think that it it not big problem to keep the name.

> 
>>> +
>>>  	if (devfreq->suspend_freq)
>>>  		devfreq->resume_freq = cur_freq;
>>>  
>>> diff --git a/include/trace/events/devfreq.h b/include/trace/events/devfreq.h
>>> index cf5b8772175d..a62d32fe3c33 100644
>>> --- a/include/trace/events/devfreq.h
>>> +++ b/include/trace/events/devfreq.h
>>> @@ -8,6 +8,24 @@
>>>  #include <linux/devfreq.h>
>>>  #include <linux/tracepoint.h>
>>>  
>>> +TRACE_EVENT(devfreq_frequency,
>>> +	TP_PROTO(struct devfreq *devfreq, unsigned long freq),
>>
>> 'unsigned long freq' parameter is not necessary.
>>
>>> +
>>> +	TP_ARGS(devfreq, freq),
>>> +
>>> +	TP_STRUCT__entry(
>>> +		__string(dev_name, dev_name(&devfreq->dev))
>>> +		__field(unsigned long, freq)
>>> +	),
>>> +
>>> +	TP_fast_assign(
>>> +		__assign_str(dev_name, dev_name(&devfreq->dev));
>>> +		__entry->freq = freq;
>>
>> Initialize the new frequency with 'devfreq->previous_freq' as following:
>>
>> 		__entry->freq = devfreq->previous_freq;
>>
>>> +	),
>>> +
>>> +	TP_printk("dev_name=%s freq=%lu", __get_str(dev_name), __entry->freq)
>>> +);
>>> +
>>>  TRACE_EVENT(devfreq_monitor,
>>>  	TP_PROTO(struct devfreq *devfreq),
>>>  
>>>
>>
>>
>> -- 
>> Best Regards,
>> Chanwoo Choi
>> Samsung Electronics
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

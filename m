Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC40A1BB9F
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2019 19:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729687AbfEMRQ3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 May 2019 13:16:29 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50852 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729493AbfEMRQ3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 May 2019 13:16:29 -0400
Received: from mail-pf1-f197.google.com ([209.85.210.197])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hQEYt-0005ps-30
        for linux-pm@vger.kernel.org; Mon, 13 May 2019 17:16:27 +0000
Received: by mail-pf1-f197.google.com with SMTP id u7so3896948pfh.17
        for <linux-pm@vger.kernel.org>; Mon, 13 May 2019 10:16:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=2WuRwt1BUMyiCONirk08ch3xQZwKTcRL8gA1P1lbcVY=;
        b=nHg90acuvaxIfiY88umGJ7P9m+rKGuRFpLL9XjijqG7W83AJgFeejOUeFfazk9geaA
         7bZ36RW9k/He6iItQ9IeD1vDbvnxTFNwfltgffZObpZB/V/JAOgXZs/6isD8bNxo7UB6
         zHBpbBY27qW/QFOsH1E8g1M/gNyp+owz/d5vcBDsZtC+MGOCSZujfY9Ak1hR+vZE9sQi
         IBK+KWrXpDlhfI+VUvK1o2oqIcBCT+jPUKvqQoyQvmvW70QOkF3yngVWUQYOxNHNvUU3
         UlTLqT3OooznaXRcM54IFdTpYZfdStLiKx0LAmcM+o/AYOwUTYRqzAeuqmRBF+fgZsZk
         qIaA==
X-Gm-Message-State: APjAAAUa0FvEugp0fAMJrJTYoMEgwBgk8i9j+o5Du2lInEdZMv2faYT+
        iTyb6HMBx4oc5cxHwwSap8mkZOAfUkUnXslh8Mx1cHX61AJHroqyf1EsF4wparPBraSFe/7z8J9
        W8sL2hGMG9hLzhMh1cB7Vd2Pb+SHw53GfEBIO
X-Received: by 2002:a17:902:a415:: with SMTP id p21mr18635792plq.286.1557767785686;
        Mon, 13 May 2019 10:16:25 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwMpzkZBKa20L76h9qBox5leOqsefklOh+TGG6aIlOpne804YEEwfQcwN3ICe6Tsy0hWCt7CA==
X-Received: by 2002:a17:902:a415:: with SMTP id p21mr18635760plq.286.1557767785478;
        Mon, 13 May 2019 10:16:25 -0700 (PDT)
Received: from 2001-b011-380f-14b9-a00c-6f16-94cc-5640.dynamic-ip6.hinet.net (2001-b011-380f-14b9-a00c-6f16-94cc-5640.dynamic-ip6.hinet.net. [2001:b011:380f:14b9:a00c:6f16:94cc:5640])
        by smtp.gmail.com with ESMTPSA id k3sm6695967pfa.36.2019.05.13.10.16.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 10:16:24 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH] nvme/pci: Use host managed power state for suspend
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20190513151652.GB15437@localhost.localdomain>
Date:   Tue, 14 May 2019 01:16:22 +0800
Cc:     Christoph Hellwig <hch@lst.de>, Mario.Limonciello@dell.com,
        keith.busch@intel.com, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <9AE4A3E7-CDB8-4730-8B4E-43C93FC0C47F@canonical.com>
References: <20190510212937.11661-1-keith.busch@intel.com>
 <0080aaff18e5445dabca509d4113eca8@AUSX13MPC105.AMER.DELL.COM>
 <955722d8fc16425dbba0698c4806f8fd@AUSX13MPC105.AMER.DELL.COM>
 <20190513143754.GE15318@localhost.localdomain>
 <7ab8274ef1ce46fcae54a50abc76ae4a@AUSX13MPC105.AMER.DELL.COM>
 <20190513145708.GA25897@lst.de>
 <20190513151652.GB15437@localhost.localdomain>
To:     Keith Busch <kbusch@kernel.org>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

at 23:16, Keith Busch <kbusch@kernel.org> wrote:

> On Mon, May 13, 2019 at 04:57:08PM +0200, Christoph Hellwig wrote:
>> On Mon, May 13, 2019 at 02:54:49PM +0000, Mario.Limonciello@dell.com  
>> wrote:
>>> And NVME spec made it sound to me that while in a low power state it  
>>> shouldn't
>>> be available if the memory isn't available.
>>>
>>> NVME spec in 8.9:
>>>
>>> "Host software should request that the controller release the
>>> assigned ranges prior to a shutdown event, a Runtime D3 event, or any  
>>> other event
>>> that requires host software to reclaim the assigned ranges."
>>
>> The last part of the quoted text is the key - if the assigned range
>> is reclaimed, that is the memory is going to be used for something else,
>> we need to release the ranges.  But we do not release the ranges,
>> as we want to keep the memory in use so that we can quickly use it
>> again.
>
> Yes, this. As far as I know, the host memory range is still accessible in
> the idle suspend state. If there are states in which host memory is not
> accessible, a reference explaining the requirement will be most helpful.

Disabling HMB prior suspend makes my original patch work without memory  
barrier.

However, using the same trick on this patch still freezes the system during  
S2I.

Kai-Heng

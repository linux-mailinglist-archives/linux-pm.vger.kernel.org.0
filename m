Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A79DE7293
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2019 14:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfJ1N11 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Oct 2019 09:27:27 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43219 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbfJ1N11 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Oct 2019 09:27:27 -0400
Received: by mail-pl1-f193.google.com with SMTP id v5so5571531ply.10;
        Mon, 28 Oct 2019 06:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=m82WuZFIPuaz/xDcmdAtFNmGLYLSIvKFnSpY+e0Rr/8=;
        b=XxsLjvXeFlFJnZv77GLwIK8SZNTDqwb7cc7HQmkcu+gGtubvG+oi5kLcn641B9uAhT
         Imjkr4zOwiheXC3Tt0akZPdeScucEhxZ2Bojhcn3R2IRGuN0odNBNR+TqxObUfc6V5Lq
         BDEWPO1h1cMeCIFUajcaa35JqDV2ou1RDxCShbPUVfd9AQ9cxfFE8vrMCi4rfXJSQb8x
         leLUKF/nPTnbJledc6kcNlxN74x9H6hc3zoNt9D/1ANS2tFiyLEEA7Eb4M+s4HNGgJ+w
         BQJfJzTTIDdR6lCXqkQY0Ftanam8+QoiKwhdzUXInM1sJkiOfV30sfSDNvw+4DM5fQsD
         T4fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=m82WuZFIPuaz/xDcmdAtFNmGLYLSIvKFnSpY+e0Rr/8=;
        b=At88Bmhnacp8chGv30MopUg+vERosSR5RPJShYd9F1lsSaFnPNTQLYaCnsXGZPvVy1
         LTJtis01xiC4dmGwnoC+KDhDzUbBHVCWVrUzxuBYbxzrAKkypWiCgb1mED8kqW7x0s9t
         2fvwBpkyKsRqTFDm3zB8bq7cn9PUTd4V/+Mfr7BZWQAFk7hOi//L9DDo2yepCoycg0OU
         M6sKjgUwhQQbEeu0g8O49heB3NRIlVRH6Dk9wujTQiSNkzQ5iAqDhtTlXzmk9NaQXLMG
         E3d7yco8GAXLh4laEbuzzRiy48HdV6Ghjw35z+OA+SKRfa8cZZ3lLP7n8QLrArkKsYzM
         VPCQ==
X-Gm-Message-State: APjAAAVidmjmvw5cj8txizE2hb7TzN1ze9WK1u8Ls9LqLMzcq0Ks58Ex
        OivLYE4ZxuHMxonIcbZV2YQnK2Dc
X-Google-Smtp-Source: APXvYqyfNFfZt/94g2Xhm2J+dNpQR0RuL4kH0F5u4ynhxy1z3BUV6UuA9j66ce9Mw/+x+BBmq09mZg==
X-Received: by 2002:a17:902:6ac3:: with SMTP id i3mr11909551plt.294.1572269245749;
        Mon, 28 Oct 2019 06:27:25 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a16sm11940383pfa.53.2019.10.28.06.27.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Oct 2019 06:27:24 -0700 (PDT)
Subject: Re: [PATCH] nvme: Add hardware monitoring support
To:     Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc:     Chris Healy <Chris.Healy@zii.aero>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        Akinobu Mita <akinobu.mita@gmail.com>, linux-pm@vger.kernel.org
References: <20191028024156.23964-1-linux@roeck-us.net>
 <20191028073953.GA20443@lst.de>
 <20191028080858.GB1718@redsun51.ssa.fujisawa.hgst.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <769941ad-22a7-a046-60cd-b084457d9789@roeck-us.net>
Date:   Mon, 28 Oct 2019 06:27:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191028080858.GB1718@redsun51.ssa.fujisawa.hgst.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/28/19 1:08 AM, Keith Busch wrote:
> On Mon, Oct 28, 2019 at 08:39:53AM +0100, Christoph Hellwig wrote:
>> On Sun, Oct 27, 2019 at 07:41:56PM -0700, Guenter Roeck wrote:
>>> nvme devices report temperature information in the controller information
>>> (for limits) and in the smart log. Currently, the only means to retrieve
>>> this information is the nvme command line interface, which requires
>>> super-user privileges.
>>>
>>> At the same time, it would be desirable to use NVME temperature information
>>> for thermal control.
>>>
>>> This patch adds support to read NVME temperatures from the kernel using the
>>> hwmon API and adds temperature zones for NVME drives. The thermal subsystem
>>> can use this information to set thermal policies, and userspace can access
>>> it using libsensors and/or the "sensors" command.
>>
>> So these reported values seem to generate some interest.  Adding Akinobu
>> Mita who also planned to wire them up to the thermal framework.  I don't
>> really know either upper layer so I'm not sure which is the right one,
>> but with this just like with the previous series I am quite worried that
>> we add a lot of kernel boilerplate code for information people can
>> trivially get using nvme-cli.
>  > I think it's nvme-cli requires root, where this conveniently doesn't
> need those elevated rights.
> 

The other point here is the thermal framework. One can not wire that up
through userspace, and even if it was possible to do it, that would defeat
the idea of having the thermal subsystem in the kernel running on its own,
without requiring userspace attention.

> I'm not familiar with either upper level framework either; my only review
> comment for this patch is to use devm_kfree() for the error cases.
> 
Makes sense. I'll address that in v2.

Guenter

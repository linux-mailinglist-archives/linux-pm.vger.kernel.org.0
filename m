Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1DB335A0E
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2019 12:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfFEKCA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Jun 2019 06:02:00 -0400
Received: from mout.gmx.net ([212.227.15.15]:53403 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726988AbfFEKCA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 5 Jun 2019 06:02:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559728900;
        bh=UsET9Lll5M+CoTqv+pj38b2HWnBKUKBonnb58LGMBT4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=bZD59ZmWY0Ntwhnge76QXnUAewp8/FaivB+KFTadt2z1WLIpRJTlz9brY9UOo3mDL
         sVe8Cr8xZ1m5qfcG/T1YyyBqb40gGEvMxtqaTVdFrbXtguM54zJJ9pQiJUS5kckjVr
         FzcaSXguUpZX0EjeNG0El4SLnzdH1AAj42k2nCt4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.162] ([37.4.249.160]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N1fn0-1gb2dQ1uGm-0124AV; Wed, 05
 Jun 2019 12:01:40 +0200
Subject: Re: [PATCH 3/4] clk: bcm2835: register Raspberry Pi's firmware clk
 device
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
Cc:     linux-arm-kernel@lists.infradead.org, ptesarik@suse.com,
        sboyd@kernel.org, viresh.kumar@linaro.org, mturquette@baylibre.com,
        linux-pm@vger.kernel.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, mbrugger@suse.de, ssuloev@orpaltech.com
References: <20190604173223.4229-1-nsaenzjulienne@suse.de>
 <20190604173223.4229-4-nsaenzjulienne@suse.de> <87muiwzyrw.fsf@anholt.net>
 <17ea99902e4329db735080d1a8fc04f5c06c9bf0.camel@suse.de>
From:   Stefan Wahren <wahrenst@gmx.net>
Message-ID: <d4e0e290-5fa7-899b-c26b-691bfc32e864@gmx.net>
Date:   Wed, 5 Jun 2019 12:01:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <17ea99902e4329db735080d1a8fc04f5c06c9bf0.camel@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:9f2lQD4Z7CpbaiYWLkTMJigUa1MziLg6+z/wwaBIURmsxQgOUS5
 k2FYvw7vOfvcPi/PmfQ5fixRnOqThMuOv787Vl764hF59L8a6jmBs3NRYyoG5HAmJmv1b19
 +yvY6j7zCQUeWKyarSDtHkN+zou8bvDUL9jpBSvvfE2bD/YQ3lvm5FBWwjvJQYKdwvyBmXc
 V6NMtKpN71rZbBuSV6twg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:q4vxgRBg+Vk=:cSI8li99sc0SeLjZq6PBGa
 QZ6f42LRJFJJLcLD3cqQ8mY9OEKdD44MaT+Er+v3fQmuJoT1RMTdK/A6F4hvNqYD6DywuhSi3
 SaPRxALtUr+Jp8Fv3AkeUimHwzkgvjVgyZSMkef1mrCxUR1SF2WtZH5TX1wyITT77lYaQY/7b
 bj2m1VkzdVei2lLjOs5R7JOSgQM8rnWjSZBTBf3I9lVQxdo4DtJQVHJm+dMFaMagUTr7P16Wt
 EQRLvSSuISvwt0+t9lPSNz/WPyhNu9p+d/JPPEvNdTSWjLw3u54YIG2luGQkVwm68b6nSKUpj
 rejoSwSaq1rF1Wj6ofqdiTzytKDTf1n9MIjU4f36vJ0W6+KW6Ns61IoBDksQ6zuEI6yWCNTPx
 l/h0E8kgwSrVGvfEMVjCjtk384eYtQNYIwuLACSVtJ8r0JFcDcHNL1/mBPfhynGjTdvEKX4gw
 qYV14E7sCt3VgpUARbVj09YuuYBGVtum9phmcLP30a/2GUNA+FDnIaW7WmAle/QcuKyOC2ve1
 l7GEtohDJ9bYkv6HYiCbo8cde1FpaXWWcrLcdqnl8wg8jaWpbyhT5YZXRsPkiJIn4H0fIKuDt
 tpDash5HSLSInyq365xvLH7gwPG3oqGltwG/jGQ8+cfWFZ2UMJf0s065E4Zcnuvo3vRf8/3yb
 fM5KF4eLre3UJUebDgvSIz3PsguDzVEHxpc3kLrRAaR0YBXH1IO/ddwM1PZa88kZTAH62DOsi
 3fYq4DY8NaCvPXGyEjQQlgqITKRqGCYE806FquBDfKpn7taRiIeY3QkuYwmKZ1f/EsbSwGvj+
 KzVe9aMC6XbYTzOpYpKTR2S/Ct6/Ll4KoaLySUJdExAdxfXJ85uFEkAvupGEamOJdryZE2IVy
 2sJq5Qt9Y9Yp8uRN4iJa2bSAGUOrjOAIYEsd6A5rdVpaBMeoMFi5q/ChR4IOWnafHIpXKCpxp
 iYT9j/hHGM4FBvpD0s6Tuk7bFIsm1niuLu+E7jHnI2y7iRXyTdqdc
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Am 05.06.19 um 11:11 schrieb Nicolas Saenz Julienne:
> On Tue, 2019-06-04 at 17:00 -0700, Eric Anholt wrote:
>> Nicolas Saenz Julienne <nsaenzjulienne@suse.de> writes:
>>
>>> Registers clk-raspberrypi as a platform device as part of the driver's
>>> probe sequence.
>> Similar to how we have VCHI register platform devices for the services
>> VCHI provides, shouldn't we have the firmware driver register the device
>> for clk_raspberrypi?  Or put the clk provider in the fw driver instead
>> of a separate driver (no opinion on my part).
> Makes sense to me, I'll move the platform driver registration into the firmware
> driver.
Fine. Please keep in mind that you might need to add a MODULE_ALIAS
otherwise autoload won't work.

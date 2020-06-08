Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE521F1A60
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jun 2020 15:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729916AbgFHNuA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Jun 2020 09:50:00 -0400
Received: from foss.arm.com ([217.140.110.172]:53158 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729051AbgFHNuA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 8 Jun 2020 09:50:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E896831B;
        Mon,  8 Jun 2020 06:49:59 -0700 (PDT)
Received: from [10.37.12.95] (unknown [10.37.12.95])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A53A3F52E;
        Mon,  8 Jun 2020 06:49:56 -0700 (PDT)
Subject: Re: [PATCH v8 4/8] PM / EM: add support for other devices than CPUs
 in Energy Model
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-imx@nxp.com, lkp@intel.com,
        Dan Carpenter <error27@gmail.com>, kbuild-all@lists.01.org,
        Dietmar.Eggemann@arm.com, cw00.choi@samsung.com
References: <20200608115155.GY30374@kadam>
 <b347fb60-46d3-e59c-59fa-a2b10932fc49@arm.com> <20200608125127.GN22511@kadam>
 <da0debe1-73da-33f1-c24e-154c2123c522@arm.com> <20200608132507.GP22511@kadam>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <f52c83d1-8968-25a2-2d6f-f3eeceae15cb@arm.com>
Date:   Mon, 8 Jun 2020 14:49:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200608132507.GP22511@kadam>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 6/8/20 2:25 PM, Dan Carpenter wrote:
> It's not really a proper bug report so it doesn't deserve a reported-by.
> 
> Thanks, though!
> 
> regards,
> dan carpenter
> 

Thank you Dan for your work. This is very much appreciated!

Lukasz

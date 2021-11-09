Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5AB44ABA9
	for <lists+linux-pm@lfdr.de>; Tue,  9 Nov 2021 11:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245388AbhKIKlm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Nov 2021 05:41:42 -0500
Received: from foss.arm.com ([217.140.110.172]:59956 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245389AbhKIKlk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 9 Nov 2021 05:41:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 844B3101E;
        Tue,  9 Nov 2021 02:38:54 -0800 (PST)
Received: from [10.57.26.224] (unknown [10.57.26.224])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 726913F85F;
        Tue,  9 Nov 2021 02:38:53 -0800 (PST)
Subject: Re: [PATCH 1/2] Documentation: power: Add description about new
 callback for EM registration
To:     linux-kernel@vger.kernel.org
Cc:     dietmar.eggemann@arm.com, rafael@kernel.org,
        linux-pm@vger.kernel.org
References: <20211102180144.1647-1-lukasz.luba@arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <22bdfc88-983d-fc86-0abb-404eedf03274@arm.com>
Date:   Tue, 9 Nov 2021 10:38:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20211102180144.1647-1-lukasz.luba@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,


On 11/2/21 6:01 PM, Lukasz Luba wrote:
> The Energy Model (EM) registration for CPUs should now be done using
> a dedicated callback added recently into CPUFreq framework and drivers.
> 
> Commit c17495b01b72 ("cpufreq: Add callback to register with energy model")
> 
> The callback guaranties that the EM registration is called at the right
> time during driver setup. To avoid mistakes update the documentation
> to align with the existing code implementation.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>   Documentation/power/energy-model.rst | 31 ++++++++++++++--------------
>   1 file changed, 16 insertions(+), 15 deletions(-)
> 


Gentle ping. Could you have a look at these documentation
two patches and maybe pick them, please?
They are trying to solve some confusion discussed with our partners
recently.

Regards,
Lukasz

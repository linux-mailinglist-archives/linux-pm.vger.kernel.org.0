Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9F0213F9BC
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2020 20:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729423AbgAPTqt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jan 2020 14:46:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:41854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729414AbgAPTqt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 16 Jan 2020 14:46:49 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E49F520730;
        Thu, 16 Jan 2020 19:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579204009;
        bh=8V/2PZ1FkyIN/o3VTS320KUawQRKhqVfY9irf7e1nT4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mozNgQFQeRo+Rdn8kLBrHSIMuh/0aSBVNGOe6Et7PFAOhZ73xoO9VDP5oK9Cs47Ix
         6sr+E52vz7UcuhUQfQEdLjhZ/s1l3XraCuzUGDEaA15DE31i6OBHgmsnO8zsSTioSW
         4HEQaGkf0TfBYXjlpHJMq3qZZA7r9aCA5/QaKaMc=
Subject: Re: [PATCH v2] cpupower: Revert library ABI changes from commit
 ae2917093fb60bdc1ed3e
To:     Thomas Renninger <trenn@suse.de>, linux-pm@vger.kernel.org
Cc:     Abhishek Goel <huntbag@linux.vnet.ibm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, shuah <shuah@kernel.org>
References: <2924229.7vsBmOEbcj@skinner.arch.suse.de>
From:   shuah <shuah@kernel.org>
Message-ID: <e1cbf0d0-361f-1113-2718-e4ee8941731f@kernel.org>
Date:   Thu, 16 Jan 2020 12:46:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <2924229.7vsBmOEbcj@skinner.arch.suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 1/14/20 2:49 AM, Thomas Renninger wrote:
> Commit ae2917093fb60bdc1ed3e modified the library function:
>      
> struct cpufreq_available_frequencies
> *cpufreq_get_available_frequencies(unsigned int cpu)
> 
> to
> struct cpufreq_frequencies
> *cpufreq_get_frequencies(const char *type, unsigned int cpu)
> 
> This patch recovers the old API and implements the new functionality
> in a newly introduce method:
> struct cpufreq_boost_frequencies
> *cpufreq_get_available_frequencies(unsigned int cpu)
> 
> 
> This one should get merged into stable kernels back to 5.0 when
> commit ae2917093fb60bdc1ed3e had been introduced.
> 
> Fixes: ae2917093fb6 ("tools/power/cpupower: Display boost frequency
> separately")
> 

Missing Signed-off-by :(

thanks,
-- Shuah

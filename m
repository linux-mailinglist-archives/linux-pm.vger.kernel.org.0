Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D873224AE3F
	for <lists+linux-pm@lfdr.de>; Thu, 20 Aug 2020 07:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgHTFEP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Aug 2020 01:04:15 -0400
Received: from mga09.intel.com ([134.134.136.24]:45660 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbgHTFEO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 20 Aug 2020 01:04:14 -0400
IronPort-SDR: LAI45mVG2xLY0ONW7CGjQsLhPLCGtL3dptEEGuQRbXqfRYMIXjsQuWJw9aLMCRtpIqNI+w5zZe
 UAFa2pXdSGIQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9718"; a="156307267"
X-IronPort-AV: E=Sophos;i="5.76,332,1592895600"; 
   d="scan'208";a="156307267"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2020 22:04:14 -0700
IronPort-SDR: 5ew4P0zvnHwOu7lJzv+xOjVYlGdfsv79mm0uX03gaziLHUvawKN3Sx8MLKVZCyYgrqcDwdHdi1
 5Fv9ZawvzNRg==
X-IronPort-AV: E=Sophos;i="5.76,332,1592895600"; 
   d="scan'208";a="441846299"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.3]) ([10.239.13.3])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2020 22:04:11 -0700
Subject: Re: [clk] a2499eff4b: BUG:kernel_NULL_pointer_dereference,address
To:     Stephen Boyd <sboyd@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Lukasz Luba <lukasz.luba@arm.com>, 0day robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
References: <20200811084943.GC7488@shao2-debian>
 <159780681339.334488.10402512224012716827@swboyd.mtv.corp.google.com>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <be4c9098-98a2-e9c0-b787-57fa7d7da24f@intel.com>
Date:   Thu, 20 Aug 2020 13:03:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <159780681339.334488.10402512224012716827@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 8/19/20 11:13 AM, Stephen Boyd wrote:
> Quoting kernel test robot (2020-08-11 01:49:44)
>> Greeting,
>>
>> FYI, we noticed the following commit (built with gcc-9):
>>
>> commit: a2499eff4b30a85d56e4466e6ca4746c72a347c6 ("[PATCH v2] clk: samsung: Keep top BPLL mux on Exynos542x enabled")
>> url: https://github.com/0day-ci/linux/commits/Marek-Szyprowski/clk-samsung-Keep-top-BPLL-mux-on-Exynos542x-enabled/20200807-213239
>> base: https://git.kernel.org/cgit/linux/kernel/git/clk/linux.git clk-next
>>
>> in testcase: trinity
>> with following parameters:
>>
>>          runtime: 300s
>>
>> test-description: Trinity is a linux system call fuzz tester.
>> test-url: http://codemonkey.org.uk/projects/trinity/
>>
>>
>> on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> Cool robot. But this doesn't look related to the patch at all?

Hi Stephen,

Sorry for the inconvenience, you are right, we run more times
on the parent commit and can reproduce the error too.

Best Regards,
Rong Chen



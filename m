Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94532367D4
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2019 01:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbfFEXX0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Jun 2019 19:23:26 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:52567 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbfFEXXZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Jun 2019 19:23:25 -0400
Received: from [192.168.1.110] ([77.2.1.21]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MnaTt-1gsD5h2gbN-00jYtF; Thu, 06 Jun 2019 01:22:40 +0200
Subject: Re: [PATCH 2/3] drivers: scsi: remove unnecessary #ifdef MODULE
To:     "Elliott, Robert (Servers)" <elliott@hpe.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "khalid@gonehiking.org" <khalid@gonehiking.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "aacraid@microsemi.com" <aacraid@microsemi.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
References: <1559397700-15585-1-git-send-email-info@metux.net>
 <1559397700-15585-3-git-send-email-info@metux.net>
 <AT5PR8401MB1169E817136F8B8587C7A716AB1A0@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <d377a82b-4269-e25d-2329-573db355877c@metux.net>
Date:   Wed, 5 Jun 2019 23:22:34 +0000
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <AT5PR8401MB1169E817136F8B8587C7A716AB1A0@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:jaekdmyV0q8OXz6r78GsYt8MpdcLc2b7djaJTQADjW9KcsKTnTr
 7wzYYHu/4yX6GYfdyY9cMfgupQEDbjo5H3ALS3nquim0kfTf+14HZ7nwJAGJ9CZgCbeXBxT
 LD/q1AJlxJLEn8noXHg2doZ+YoMtmGD4PHOu+E9ONVyw+ldThp50wbmHoHx8M9awmGecgj8
 hxGR04XtnMvP4o9EJ9qow==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:vWKltpJs204=:0nJ0fYNT/FkUdt8WwReLvN
 m59Xkghuq3N+fsmaJgJ1/c246RmrR9XAB3PkwvqlcLlFtteQh1S2yu1ZnFfTi+OCj4mRuHq8u
 fBk+ZpyqlLWQU3YVtOsbjRuoB+ExRwniu8suLAp64O0VLlZabKxMsETDROGAAoLoew1tf+TwP
 RX4m+yMn5JfVf4Z4B/fUBIRRo6KRR/NriUxfac5FIv265NxnZmBre2o4MqAEb191cElXyg4WE
 RNux37jM2IuB2oiVDi1q6siKFGoFegE4e9U0k2fp0eb6rXkg0epM3QYYwqsEwXpaiKzCuv2Qx
 QyjPNaTIzvTwf2yi6Pz/TwLtXuXhwp66YgmAMIwh0z+T7FtkRrGIHkco3yCJI3wH0YYkjb7qY
 YqNEdFcwgTpvXVnUyptIZ5HflNwgjb6rKeIOR7uPw20k8VqrzI/YCAThV0evAwNF9QEnR16UA
 f2D4duZHmBHClZpY0Wz4qzpAGCLje01jFy0560+bUwDP4mUV6bytsT7VmHr3FQ/g+umR/RFrM
 RuokkZnPuoxbx1V1+qofubE9Goi4bEdxljXM7c1kKF/zzbKdNZi1/X/SjzeUWfb+/wGS5Z2bs
 2oEV2jvaLT/3UEGkoEohLVRnF3tuSVAQnlqhbVTdHK/wbsTozAB3xPMKFNFsx0JQDDYcPjXIY
 aSIcTrC6OlimGIq8qsqCWxz8Z1WtucZFx51fEzX74N+/6mA7ue31Qyqw/eEGDv2Rvaiu4Eaj+
 eiLTKMEUkT/iRM1IBfjiiKt7LYZcgEjw/81+IOjNNVjbn0+rS8J6elS6UDs=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 01.06.19 15:40, Elliott, Robert (Servers) wrote:

<snip>

> I don't see any reply to James' comment that these changes result in

I've missed that mail :(

> static struct definitions that are unused, which should result in
> complaints by the compiler like:
>      warning: 'dptids' defined by not used [-Wunused-variable]

hmm, seems that const is missing on dptids ... I'll test that and
repost fixed vrsion.

--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287

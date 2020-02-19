Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC511163E58
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2020 09:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgBSIAM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Feb 2020 03:00:12 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:49922 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgBSIAL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Feb 2020 03:00:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=trpPk2WCBAaB8e66Xo0uUXjYRjRhuDQkfqxMFp/+GPg=; b=uagqCpIVPVHVsTkn56aoqnkANj
        x5c0XkQ7Ss8xfD4ifDJ5mbST4AYb4uQ9CK11geJLE6Bc5kkHkTx614fUuOaLFYWPV+xsXprgfqvgT
        7JYI5Dof2/QM23L2QkVz+WJfIXaN9CdXbg3dFb3m6qO1yeZguDtT/SLWmFjzGvJ+cmfzn1ZEWWgC6
        NwtNFgI6d7fpG34CM0PQyg8SbicK5XvTa2ut6+rI64Cgobo5qzLgMeFQs17SmZ2UulQ7Mdv2FloC9
        Yurv+dBoKF3+c7UeIg8mvcwfYzrEds9rV7UpNiZG6xxCeucosZ+WHUzeOJGfMJed+J+mRDcfJLOkz
        xs+VYH3g==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4KHC-0007fE-Hu; Wed, 19 Feb 2020 08:00:10 +0000
Subject: Re: [PATCH v3 2/2] driver core: Make deferred_probe_timeout global so
 it can be shared
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Todd Kjos <tkjos@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-pm@vger.kernel.org
References: <20200218220748.54823-1-john.stultz@linaro.org>
 <20200218220748.54823-2-john.stultz@linaro.org>
 <20200219075730.GA2732797@kroah.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e67836f6-dcaa-c7b6-0779-35a9ff98ba38@infradead.org>
Date:   Wed, 19 Feb 2020 00:00:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200219075730.GA2732797@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2/18/20 11:57 PM, Greg Kroah-Hartman wrote:
> On Tue, Feb 18, 2020 at 10:07:48PM +0000, John Stultz wrote:
>> --- a/include/linux/device/driver.h
>> +++ b/include/linux/device/driver.h
>> @@ -236,6 +236,7 @@ driver_find_device_by_acpi_dev(struct device_driver *drv, const void *adev)
>>  }
>>  #endif
>>  
>> +extern int deferred_probe_timeout;
>>  void driver_deferred_probe_add(struct device *dev);
> 
> If this is going to be global now, can you rename it to
> "driver_defferred_probe_timeout" to make it more in line with the other

or driver_deferred_probe_timeout please.

> exported symbols here?


-- 
~Randy


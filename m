Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 647CF174FB9
	for <lists+linux-pm@lfdr.de>; Sun,  1 Mar 2020 21:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgCAUxM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 Mar 2020 15:53:12 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:42842 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgCAUxM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 1 Mar 2020 15:53:12 -0500
Received: by mail-yw1-f66.google.com with SMTP id n127so9156500ywd.9
        for <linux-pm@vger.kernel.org>; Sun, 01 Mar 2020 12:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=bDaDpWDzIuINJaeNKQ8LzrSaXL2HTruooBYf7HvA7Eo=;
        b=EmjVNr3XsE6iLfJuQRL0muXdEJAiIyL3Y+jPm6+ePhkA22A4Mz6VWiLTAkLalxBn2v
         utg2WNjmPm0LQ7z4o2gnnDQm4+5FVg4gVvCB6+HNN+089OcaEUUXXzTnsfTX0pkEE24t
         zSVEajAvR7kFRkabfUd9JflyThNgSWvVJHA+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=bDaDpWDzIuINJaeNKQ8LzrSaXL2HTruooBYf7HvA7Eo=;
        b=hCsjhXvEN3gulKkoUBWUR0D7P79427L+0p9EDkYcgRvMBiPK979hnwnPbAEYRlQ3jQ
         AZTJgNmKVgIgwYCsB5OHNCpSH8G2FC4iMUSRpmYluuFSsdDrk9kr71y2UQdF0Gg6vGft
         R0PXgSNt8UfFBnUSkvBON3LRmxwXVcMD5OgWHp0bNuJB9zPlxmV8tqOO52wqt0pSe+b4
         Wx/PJD503UhlhN8ftq1tf4lzszzcL169PrGqvqbCjG8kdDyERCSawJYXZSCNziuM/8MA
         QUDbRMEwGG+mGqq3QEexkvOsZDN31rkBJw1HCZw4ezqKBaiWyw+0/+0wRHSLmLK1xpJJ
         SA/w==
X-Gm-Message-State: APjAAAU0D6MUq2T3pPetAD8IJUt+SMtTa5y+orG4brMFrc3/epNwIN4Q
        2ZpoQsgWIUTArk79Q0YncfkE9Q==
X-Google-Smtp-Source: APXvYqx3P8icet9HUO2aeTeE20820x8zQCh6UpI57dcrgc23oibLE9SWZ59F1Ozn7E08XtG9nRgNoQ==
X-Received: by 2002:a81:f10a:: with SMTP id h10mr13376846ywm.109.1583095990710;
        Sun, 01 Mar 2020 12:53:10 -0800 (PST)
Received: from ?IPv6:2600:1004:b051:ad4e:accd:3cda:58d9:2348? ([2600:1004:b051:ad4e:accd:3cda:58d9:2348])
        by smtp.gmail.com with ESMTPSA id c85sm3746327ywb.81.2020.03.01.12.53.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Mar 2020 12:53:10 -0800 (PST)
Date:   Sun, 01 Mar 2020 15:53:07 -0500
User-Agent: K-9 Mail for Android
In-Reply-To: <CAJZ5v0jhw+cVm=ViiOtZgKr+a1L_PbeVPNXpsPbgghUvMPODSA@mail.gmail.com>
References: <20200228174630.8989-1-madhuparnabhowmik10@gmail.com> <CAJZ5v0jhw+cVm=ViiOtZgKr+a1L_PbeVPNXpsPbgghUvMPODSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/2] drivers: base: power: main: Use built-in RCU list checking
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        madhuparnabhowmik10@gmail.com
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        frextrite@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org, paulmck@kernel.org
From:   joel@joelfernandes.org
Message-ID: <C2E57D31-A459-4F5F-8ECF-484FBB26C065@joelfernandes.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On March 1, 2020 3:12:53 PM EST, "Rafael J=2E Wysocki" <rafael@kernel=2Eor=
g> wrote:
>On Fri, Feb 28, 2020 at 6:47 PM <madhuparnabhowmik10@gmail=2Ecom> wrote:
>>
>> From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail=2Ecom>
>>
>> This patch passes the cond argument to list_for_each_entry_rcu()
>> to fix the following false-positive lockdep warnings:
>>
>> [  330=2E302784] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> [  330=2E302789] WARNING: suspicious RCU usage
>> [  330=2E302796] 5=2E6=2E0-rc1+ #5 Not tainted
>> [  330=2E302801] -----------------------------
>> [  330=2E302808] drivers/base/power/main=2Ec:326 RCU-list traversed in
>non-reader section!!
>>
>> [  330=2E303303] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> [  330=2E303307] WARNING: suspicious RCU usage
>> [  330=2E303311] 5=2E6=2E0-rc1+ #5 Not tainted
>> [  330=2E303315] -----------------------------
>> [  330=2E303319] drivers/base/power/main=2Ec:1698 RCU-list traversed in
>non-reader section!!
>>
>> [  331=2E934969] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> [  331=2E934971] WARNING: suspicious RCU usage
>> [  331=2E934973] 5=2E6=2E0-rc1+ #5 Not tainted
>> [  331=2E934975] -----------------------------
>> [  331=2E934977] drivers/base/power/main=2Ec:1238 RCU-list traversed in
>non-reader section!!
>>
>> [  332=2E467772] WARNING: suspicious RCU usage
>> [  332=2E467775] 5=2E6=2E0-rc1+ #5 Not tainted
>> [  332=2E467775] -----------------------------
>> [  332=2E467778] drivers/base/power/main=2Ec:269 RCU-list traversed in
>non-reader section!!
>
>I don't see these warnings in the kernels run locally here=2E
>
>What do you do to get them?
>
>Joel, any comments here?

You have to enable lockdep in your config=2E Does your setup have that?

Thanks,

- Joel


>
>>
>> Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail=2Ecom>
>> ---
>>  drivers/base/power/main=2Ec | 12 ++++++++----
>>  1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/base/power/main=2Ec b/drivers/base/power/main=2Ec
>> index 0e99a760aebd=2E=2E742c05f3c1e7 100644
>> --- a/drivers/base/power/main=2Ec
>> +++ b/drivers/base/power/main=2Ec
>> @@ -266,7 +266,8 @@ static void dpm_wait_for_suppliers(struct device
>*dev, bool async)
>>          * callbacks freeing the link objects for the links in the
>list we're
>>          * walking=2E
>>          */
>> -       list_for_each_entry_rcu(link, &dev->links=2Esuppliers, c_node)
>> +       list_for_each_entry_rcu(link, &dev->links=2Esuppliers, c_node,
>> +                               device_links_read_lock_held())
>>                 if (READ_ONCE(link->status) !=3D DL_STATE_DORMANT)
>>                         dpm_wait(link->supplier, async);
>>
>> @@ -323,7 +324,8 @@ static void dpm_wait_for_consumers(struct device
>*dev, bool async)
>>          * continue instead of trying to continue in parallel with
>its
>>          * unregistration)=2E
>>          */
>> -       list_for_each_entry_rcu(link, &dev->links=2Econsumers, s_node)
>> +       list_for_each_entry_rcu(link, &dev->links=2Econsumers, s_node,
>> +                                device_links_read_lock_held())
>>                 if (READ_ONCE(link->status) !=3D DL_STATE_DORMANT)
>>                         dpm_wait(link->consumer, async);
>>
>> @@ -1235,7 +1237,8 @@ static void dpm_superior_set_must_resume(struct
>device *dev)
>>
>>         idx =3D device_links_read_lock();
>>
>> -       list_for_each_entry_rcu(link, &dev->links=2Esuppliers, c_node)
>> +       list_for_each_entry_rcu(link, &dev->links=2Esuppliers, c_node,
>> +                                device_links_read_lock_held())
>>                 link->supplier->power=2Emust_resume =3D true;
>>
>>         device_links_read_unlock(idx);
>> @@ -1695,7 +1698,8 @@ static void
>dpm_clear_superiors_direct_complete(struct device *dev)
>>
>>         idx =3D device_links_read_lock();
>>
>> -       list_for_each_entry_rcu(link, &dev->links=2Esuppliers, c_node)
>{
>> +       list_for_each_entry_rcu(link, &dev->links=2Esuppliers, c_node,
>> +                                device_links_read_lock_held()) {
>>                 spin_lock_irq(&link->supplier->power=2Elock);
>>                 link->supplier->power=2Edirect_complete =3D false;
>>                 spin_unlock_irq(&link->supplier->power=2Elock);
>> --
>> 2=2E17=2E1
>>

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E

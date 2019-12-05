Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE13113EE5
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2019 10:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbfLEJ7C (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Dec 2019 04:59:02 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:46456 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728955AbfLEJ7C (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Dec 2019 04:59:02 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20191205095900euoutp019bc25b6272cc576ae18b28253ca367a2~dcTphqwPB2869928699euoutp01c
        for <linux-pm@vger.kernel.org>; Thu,  5 Dec 2019 09:59:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20191205095900euoutp019bc25b6272cc576ae18b28253ca367a2~dcTphqwPB2869928699euoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575539940;
        bh=2iFFLPwuAPzBhKo8EtLPGgHosjwmyad+fXz8EYtiRFw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=FETg+MhA0UJV7uNaVgtXZfdXX7juBwuwYK5WBUwfqTCIeGo6JTJRIIo/ou05LHKwG
         ZACwmQ65oOLvjLLLkzeQlujdU+S3OYID7asdC/EO9uBAia26e6+1dRtNvbwprtGKzT
         w+a6La1TYEg7lceqoqJOzvLl3IpzlJGikKx7fOLI=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191205095859eucas1p1ec0fe44dd7acee3855873ce3b264acea~dcTpPMsbB0757607576eucas1p1Q;
        Thu,  5 Dec 2019 09:58:59 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 70.85.60698.3E4D8ED5; Thu,  5
        Dec 2019 09:58:59 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191205095859eucas1p1710f118a0b967821ff86b380ec5a12be~dcTo4hh1f1054410544eucas1p11;
        Thu,  5 Dec 2019 09:58:59 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191205095859eusmtrp14768f9612c43db3667ab13d912dab23f~dcTo324562247522475eusmtrp1L;
        Thu,  5 Dec 2019 09:58:59 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-5b-5de8d4e35af4
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 5D.93.08375.3E4D8ED5; Thu,  5
        Dec 2019 09:58:59 +0000 (GMT)
Received: from [106.120.51.18] (unknown [106.120.51.18]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191205095859eusmtip16d26110a97f8836e8541075ad3ef2ac4~dcTob2FTf2609726097eusmtip1H;
        Thu,  5 Dec 2019 09:58:58 +0000 (GMT)
Subject: Re: [PATCH v2 1/3] devfreq: change time stats to 64-bit
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
From:   Kamil Konieczny <k.konieczny@samsung.com>
Message-ID: <b6e26205-7aa0-7502-c936-76a031b3b1d6@samsung.com>
Date:   Thu, 5 Dec 2019 10:58:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <0fd243ee-001e-a93a-3421-3e3c82947f11@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMKsWRmVeSWpSXmKPExsWy7djP87qPr7yINVg239hi44z1rBbXvzxn
        tTh/fgO7xdmmN+wWl3fNYbP43HuE0WLtkbvsFrcbV7A5cHhsWtXJ5tG3ZRWjx+dNcgHMUVw2
        Kak5mWWpRfp2CVwZlxcdYS7YL1Ox+uRBtgbGBeJdjJwcEgImEhf6rrCD2EICKxglnj8CsrmA
        7C+MEgsONDNDOJ8ZJbqufmWB6fj66hZUYjmjxLLVy6Cct4wSp3oPgM0SFnCQmPT6LTOILSKg
        ITHz7xVGkCJmgXlMEm+mXWAFSbAJ6EscPHsSbCyvgJ3EmbbvTCA2i4CKxOwjM4FsDg5RgQiJ
        018TIUoEJU7OfAJWzilgLzFvyT2wXcwC4hK3nsxngrDlJba/ncMMcek6dokbq3NBxkgIuEg0
        XAuDCAtLvDq+hR3ClpE4PbkH6rFyiacL+8DelxBoYZR40P4RKmEtcfj4RVaQOcwCmhLrd+lD
        hB0lVl7/zwYxnk/ixltBiAv4JCZtm84MEeaV6GgTgqhWlXh+qocJwpaW6Pq/jnUCo9IsJH/N
        QvLLLCS/zELYu4CRZRWjeGppcW56arFxXmq5XnFibnFpXrpecn7uJkZg0jn97/jXHYz7/iQd
        YhTgYFTi4W3Y9DxWiDWxrLgy9xCjBAezkgjvNomnsUK8KYmVValF+fFFpTmpxYcYpTlYlMR5
        qxkeRAsJpCeWpGanphakFsFkmTg4pRoYpcW3VoVItGj9YV93aNn8iTcOL3t9k2/N4ydNbonz
        rcoOmnxet/rejbodD/dU9p+o9XpV3uMv1ubzO6uNzSOywdr4xf3MlBqDN+nTruf6erwUdEvU
        ezjlpL27TVeT1jLhUmuudrZTO8RW9t97f/Htgei+B3ETz9ak3pvI2vaTr/Huz9W2brt3K7EU
        ZyQaajEXFScCAPQ5NrY2AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFIsWRmVeSWpSXmKPExsVy+t/xu7qPr7yINZg/Q8Zi44z1rBbXvzxn
        tTh/fgO7xdmmN+wWl3fNYbP43HuE0WLtkbvsFrcbV7A5cHhsWtXJ5tG3ZRWjx+dNcgHMUXo2
        RfmlJakKGfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWpRfp2CXoZlxcdYS7Y
        L1Ox+uRBtgbGBeJdjJwcEgImEl9f3WLuYuTiEBJYyiix6tFPNoiEtETj6dVMELawxJ9rXWwQ
        Ra8ZJfYsvcQCkhAWcJCY9PotM4gtIqAhMfPvFUaQImaBBUwS829OZIHo+MYocervB7AqNgF9
        iYNnT4J18wrYSZxp+w62gkVARWL2kZlgtqhAhMTz7TcYIWoEJU7OfAJWzylgLzFvyT12EJtZ
        QF3iz7xLzBC2uMStJ/OZIGx5ie1v5zBPYBSahaR9FpKWWUhaZiFpWcDIsopRJLW0ODc9t9hQ
        rzgxt7g0L10vOT93EyMw3rYd+7l5B+OljcGHGAU4GJV4eBs2PY8VYk0sK67MPcQowcGsJMK7
        TeJprBBvSmJlVWpRfnxRaU5q8SFGU6DnJjJLiSbnA1NBXkm8oamhuYWlobmxubGZhZI4b4fA
        wRghgfTEktTs1NSC1CKYPiYOTqkGxgiry9EdPsf6byQGXrdcdepZfvZmeaEZN+L2f3a8vuWz
        6Wq5ReXP5QSYL0S/5f6a/H1l1Z6w2E9rzLnbD4q3vKjKWseofetRhL/9Rc7Q0vpz1xQP6G99
        YWewTHb2nLOucy2vbmkOzzg9/UJbQljrSnHjJRO9bLtzLfpYEnNmTz8zM+YX/3/OtUosxRmJ
        hlrMRcWJAORAYgjNAgAA
X-CMS-MailID: 20191205095859eucas1p1710f118a0b967821ff86b380ec5a12be
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191204150033eucas1p1bf11d36a89c89e3eb55c37a1a204e988
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191204150033eucas1p1bf11d36a89c89e3eb55c37a1a204e988
References: <20191204150018.5234-1-k.konieczny@samsung.com>
        <CGME20191204150033eucas1p1bf11d36a89c89e3eb55c37a1a204e988@eucas1p1.samsung.com>
        <20191204150018.5234-2-k.konieczny@samsung.com>
        <0fd243ee-001e-a93a-3421-3e3c82947f11@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 05.12.2019 01:27, Chanwoo Choi wrote:
> On 12/5/19 12:00 AM, Kamil Konieczny wrote:
>> Change time stats counting to bigger type by using 64-bit jiffies.
>> This will make devfreq stats code look similar to cpufreq stats and
>> prevents overflow (for HZ = 1000 after 49.7 days).
>>
>> Signed-off-by: Kamil Konieczny <k.konieczny@samsung.com>
>> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
>> Changes in v2:
>>  added Acked-by, rebased on linux-next
>>
>>  drivers/devfreq/devfreq.c | 14 +++++++-------
>>  include/linux/devfreq.h   |  4 ++--
>>  2 files changed, 9 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>> index bdeb4189c978..0e2030403e4a 100644
>> --- a/drivers/devfreq/devfreq.c
>> +++ b/drivers/devfreq/devfreq.c
>> @@ -199,10 +199,10 @@ static int set_freq_table(struct devfreq *devfreq)
>>  int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
>>  {
>>  	int lev, prev_lev, ret = 0;
>> -	unsigned long cur_time;
>> +	unsigned long long cur_time;
> 
> It looks better to use 'u64' instead of 'unsigned long long'.
> Because get_jiffies_u64 has 'u64' return type.

You are right, I will change this and send v3.

>>  
>>  	lockdep_assert_held(&devfreq->lock);
>> -	cur_time = jiffies;
>> +	cur_time = get_jiffies_64();
>>  
>>  	/* Immediately exit if previous_freq is not initialized yet. */
>>  	if (!devfreq->previous_freq)
>> @@ -525,7 +525,7 @@ void devfreq_monitor_resume(struct devfreq *devfreq)
>>  			msecs_to_jiffies(devfreq->profile->polling_ms));
>>  
>>  out_update:
>> -	devfreq->last_stat_updated = jiffies;
>> +	devfreq->last_stat_updated = get_jiffies_64();
>>  	devfreq->stop_polling = false;
>>  
>>  	if (devfreq->profile->get_cur_freq &&
>> @@ -748,7 +748,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>  
>>  	devfreq->time_in_state = devm_kcalloc(&devfreq->dev,
>>  			devfreq->profile->max_state,
>> -			sizeof(unsigned long),
>> +			sizeof(*devfreq->time_in_state),
>>  			GFP_KERNEL);
>>  	if (!devfreq->time_in_state) {
>>  		mutex_unlock(&devfreq->lock);
>> @@ -756,7 +756,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>  		goto err_devfreq;
>>  	}
>>  
>> -	devfreq->last_stat_updated = jiffies;
>> +	devfreq->last_stat_updated = get_jiffies_64();
>>  
>>  	srcu_init_notifier_head(&devfreq->transition_notifier_list);
>>  
>> @@ -1470,8 +1470,8 @@ static ssize_t trans_stat_show(struct device *dev,
>>  		for (j = 0; j < max_state; j++)
>>  			len += sprintf(buf + len, "%10u",
>>  				devfreq->trans_table[(i * max_state) + j]);
>> -		len += sprintf(buf + len, "%10u\n",
>> -			jiffies_to_msecs(devfreq->time_in_state[i]));
>> +		len += sprintf(buf + len, "%10llu\n", (u64)
>> +			jiffies64_to_msecs(devfreq->time_in_state[i]));
>>  	}
>>  
>>  	len += sprintf(buf + len, "Total transition : %u\n",
>> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
>> index 2bae9ed3c783..b81a86e47fb9 100644
>> --- a/include/linux/devfreq.h
>> +++ b/include/linux/devfreq.h
>> @@ -174,8 +174,8 @@ struct devfreq {
>>  	/* information for device frequency transition */
>>  	unsigned int total_trans;
>>  	unsigned int *trans_table;
>> -	unsigned long *time_in_state;
>> -	unsigned long last_stat_updated;
>> +	u64 *time_in_state;
>> +	unsigned long long last_stat_updated;
> 
> ditto. 'unsigned long long' -> 'u64'.

Yes, will change this too.

>>  	struct srcu_notifier_head transition_notifier_list;
>>  };
>>

-- 
Best regards,
Kamil Konieczny
Samsung R&D Institute Poland


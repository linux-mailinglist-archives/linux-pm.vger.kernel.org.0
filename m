Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96201EA939
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2019 03:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbfJaCYd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Oct 2019 22:24:33 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:47137 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbfJaCYd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Oct 2019 22:24:33 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20191031022430epoutp01b14cfbc1eab63a0bf4787f9df85e5f9a~Smh1U5-Cf0199001990epoutp01f
        for <linux-pm@vger.kernel.org>; Thu, 31 Oct 2019 02:24:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20191031022430epoutp01b14cfbc1eab63a0bf4787f9df85e5f9a~Smh1U5-Cf0199001990epoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1572488670;
        bh=KEiEcE5JtlUWEtH1Ti9sgZlmVNmok7b1iI490Umrh3o=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=bO+MJSLKCvUIzcbvChprabYUOrvHd7GaVVEuWztAxw2SSBnMV12CTziPrOrLzhr19
         9wCMzDZs9o4RLzCNN1jeAR91wu6FcHX6XBT3MNormN6uu9+OwdQVSSxwP0ydTMnohH
         3WVn2pFID5pu5Z4eJnZnmyr4BL/PQGJ2frdgOSY8=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20191031022429epcas1p49913e3e670541981ed8850ef7c859a99~Smh0q1le60172501725epcas1p4P;
        Thu, 31 Oct 2019 02:24:29 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.156]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 473Tfg2z6RzMqYkg; Thu, 31 Oct
        2019 02:24:27 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        16.47.04144.8D54ABD5; Thu, 31 Oct 2019 11:24:24 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20191031022423epcas1p3419004f8dc70c050deb614dd9dfc9280~SmhusFVKu2813128131epcas1p3a;
        Thu, 31 Oct 2019 02:24:23 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191031022423epsmtrp137f91eb77549a1b1be766331b73fa202~SmhurAcbb1470414704epsmtrp1U;
        Thu, 31 Oct 2019 02:24:23 +0000 (GMT)
X-AuditID: b6c32a35-2dfff70000001030-2c-5dba45d8e851
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        4F.4B.24756.7D54ABD5; Thu, 31 Oct 2019 11:24:23 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191031022423epsmtip12b41035d8f68c3da042b32ff8b160651~Smhua5I7z3255032550epsmtip1S;
        Thu, 31 Oct 2019 02:24:23 +0000 (GMT)
Subject: Re: [PATCH v9 2/8] PM / devfreq: Fix devfreq_notifier_call
 returning errno
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <81d8e639-e52f-60b8-c584-e300b1540a33@samsung.com>
Date:   Thu, 31 Oct 2019 11:29:55 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <10b1e5f93e7594852aa5cbfe1309bf486f70ecbb.1570044052.git.leonard.crestez@nxp.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMJsWRmVeSWpSXmKPExsWy7bCmge4N112xBhMnsFocOraV3eLr6VOM
        FssuHWW0mL53E5vF+fMb2C3ONr1ht1hx9yOrxabH11gtun6tZLb43HuE0eLzhseMFrcbV7BZ
        rD53kM2i69BfNouNXz0c+D3e32hl95jdcJHFY8GmUo9NqzrZPO5c28PmsXlJvcfGdzuYPA6+
        28Pk0bdlFaPH501yAVxR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmp
        tkouPgG6bpk5QE8oKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgosC/SKE3OLS/PS
        9ZLzc60MDQyMTIEKE7Iz+jZfZC+YLlAx9eBElgbGfzxdjJwcEgImEvsu7mQBsYUEdjBKPHtj
        1cXIBWR/YpT4vW0zC4TzjVFiybT9bHAdW2ZBJfYySuy8dJYNwnnPKHF2WRszSJWwQKjEgtnr
        WUFsEYE6iVuLTzCDFDELPGeWeHpwJlgRm4CWxP4XN8DG8gsoSlz98ZgRxOYVsJPYcHUFmM0i
        oCqxa9EVoHoODlGBCInTXxMhSgQlTs58AnY3p0CcxMwPB8DGMAuIS9x6Mp8JwpaXaN46G2yv
        hMA5dokTB66xQ7zgIvFgznwoW1ji1fEtULaUxMv+Nii7WmLlySNsEM0djBJb9l9ghUgYS+xf
        OpkJ5CBmAU2J9bv0IcKKEjt/z2WEWMwn8e5rDytIiYQAr0RHmxBEibLE5Qd3mSBsSYnF7Z1s
        ExiVZiF5ZxaSF2YheWEWwrIFjCyrGMVSC4pz01OLDQsMkWN7EyM4gWuZ7mCccs7nEKMAB6MS
        D++Esp2xQqyJZcWVuYcYJTiYlUR4v9kAhXhTEiurUovy44tKc1KLDzGaAgN7IrOUaHI+MLvk
        lcQbmhoZGxtbmBiamRoaKonzOi5fGiskkJ5YkpqdmlqQWgTTx8TBKdXAeDTIfq3nGbXD3qfT
        NjyOWe9ctMNQ5d69iLupmYp/zkzmkYiW+/by8fHtRZHi765GTerOOdRYt3my5NWPX/ysDbsu
        1Hp3N8xY9UVi0naWCYX1P6T/ZWUtDpFbNMFwWXFyVMLXwg0rrp8UMskOyFI7+DBgp/0987wt
        Mub+KVNkvugznvkz5dLLQiWW4oxEQy3mouJEAEBama72AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRmVeSWpSXmKPExsWy7bCSnO51112xBo96pCwOHdvKbvH19ClG
        i2WXjjJaTN+7ic3i/PkN7BZnm96wW6y4+5HVYtPja6wWXb9WMlt87j3CaPF5w2NGi9uNK9gs
        Vp87yGbRdegvm8XGrx4O/B7vb7Sye8xuuMjisWBTqcemVZ1sHneu7WHz2Lyk3mPjux1MHgff
        7WHy6NuyitHj8ya5AK4oLpuU1JzMstQifbsEroy+zRfZC6YLVEw9OJGlgfEfTxcjJ4eEgInE
        vi2zWLoYuTiEBHYzSjw6f4ENIiEpMe3iUeYuRg4gW1ji8OFiiJq3jBLT26cyg9QIC4RKHHvd
        xgpiiwjUSfx5vo8JpIhZ4DmzxIb7X1khOh4xSrzb+RFsKpuAlsT+FzfAbH4BRYmrPx4zgti8
        AnYSG66uALNZBFQldi26ArZBVCBC4vn2G1A1ghInZz5hAbE5BeIkZn44ADaHWUBd4s+8S8wQ
        trjErSfzmSBseYnmrbOZJzAKz0LSPgtJyywkLbOQtCxgZFnFKJlaUJybnltsWGCYl1quV5yY
        W1yal66XnJ+7iREczVqaOxgvL4k/xCjAwajEwzuhbGesEGtiWXFl7iFGCQ5mJRHebzZAId6U
        xMqq1KL8+KLSnNTiQ4zSHCxK4rxP845FCgmkJ5akZqemFqQWwWSZODilGhjjyrW4d9s/PyNv
        udNT0zPu/45du09bq52PP1S4WfnVScOAO75xDOszlV1bJsbf+8pRJj/Lcs+f9u0cZbdts1J+
        qux63vVb8mdBgjDzlG/uzv+1L8W/jV9k9KRbT/1hwyHRNw/lPa1/b3i27OJ7n701Iv/TtrJ4
        J0ZdS+939BHQ/xl6PKP5xR0lluKMREMt5qLiRAAfb/8q4gIAAA==
X-CMS-MailID: 20191031022423epcas1p3419004f8dc70c050deb614dd9dfc9280
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191002192525epcas2p2261ab613edfbf976cd82daf9b7ce4802
References: <cover.1570044052.git.leonard.crestez@nxp.com>
        <CGME20191002192525epcas2p2261ab613edfbf976cd82daf9b7ce4802@epcas2p2.samsung.com>
        <10b1e5f93e7594852aa5cbfe1309bf486f70ecbb.1570044052.git.leonard.crestez@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 10. 3. 오전 4:25, Leonard Crestez wrote:
> Notifier callbacks shouldn't return negative errno but one of the
> NOTIFY_OK/DONE/BAD values.
> 
> The OPP core will ignore return values from notifiers but returning a
> value that matches NOTIFY_STOP_MASK will stop the notification chain.
> 
> Fix by always returning NOTIFY_OK.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  drivers/devfreq/devfreq.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 7dc899da1172..32bbf6e80380 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -548,30 +548,32 @@ EXPORT_SYMBOL(devfreq_interval_update);
>   */
>  static int devfreq_notifier_call(struct notifier_block *nb, unsigned long type,
>  				 void *devp)
>  {
>  	struct devfreq *devfreq = container_of(nb, struct devfreq, nb);
> -	int ret;
> +	int err = -EINVAL;
>  
>  	mutex_lock(&devfreq->lock);
>  
>  	devfreq->scaling_min_freq = find_available_min_freq(devfreq);
> -	if (!devfreq->scaling_min_freq) {
> -		mutex_unlock(&devfreq->lock);
> -		return -EINVAL;
> -	}
> +	if (!devfreq->scaling_min_freq)
> +		goto out;
>  
>  	devfreq->scaling_max_freq = find_available_max_freq(devfreq);
> -	if (!devfreq->scaling_max_freq) {
> -		mutex_unlock(&devfreq->lock);
> -		return -EINVAL;
> -	}
> +	if (!devfreq->scaling_max_freq)
> +		goto out;
> +
> +	err = update_devfreq(devfreq);
>  
> -	ret = update_devfreq(devfreq);
> +out:
>  	mutex_unlock(&devfreq->lock);
> +	if (err)
> +		dev_err(devfreq->dev.parent,
> +			"failed to update frequency from OPP notifier (%d)\n",
> +			err);
>  
> -	return ret;
> +	return NOTIFY_OK;
>  }
>  
>  /**
>   * devfreq_dev_release() - Callback for struct device to release the device.
>   * @dev:	the devfreq device
> 

Sorry for the late reply.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

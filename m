Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9692716B9F5
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2020 07:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgBYGp4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Feb 2020 01:45:56 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:24792 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725851AbgBYGpz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Feb 2020 01:45:55 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01P6jfxg166980;
        Tue, 25 Feb 2020 01:45:51 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ybu13qm2v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Feb 2020 01:45:50 -0500
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 01P6jhKO167045;
        Tue, 25 Feb 2020 01:45:43 -0500
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ybu13qm0b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Feb 2020 01:45:43 -0500
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 01P6jA14027561;
        Tue, 25 Feb 2020 06:45:35 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma02wdc.us.ibm.com with ESMTP id 2yaux6hsbr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Feb 2020 06:45:35 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01P6jZf245351314
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Feb 2020 06:45:35 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EEBB3AC059;
        Tue, 25 Feb 2020 06:45:34 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B0458AC05B;
        Tue, 25 Feb 2020 06:45:34 +0000 (GMT)
Received: from sofia.ibm.com (unknown [9.124.35.114])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 25 Feb 2020 06:45:34 +0000 (GMT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
        id 7FAAC2E2F59; Tue, 25 Feb 2020 12:15:32 +0530 (IST)
Date:   Tue, 25 Feb 2020 12:15:32 +0530
From:   Gautham R Shenoy <ego@linux.vnet.ibm.com>
To:     "Oliver O'Halloran" <oohall@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/2] cpufreq/powernv: Fix unsafe notifiers
Message-ID: <20200225064532.GJ12846@in.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
References: <20200206062622.28235-1-oohall@gmail.com>
 <20200206062622.28235-2-oohall@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200206062622.28235-2-oohall@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-25_01:2020-02-21,2020-02-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 malwarescore=0 bulkscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 adultscore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002250054
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Feb 06, 2020 at 05:26:22PM +1100, Oliver O'Halloran wrote:
> The PowerNV cpufreq driver registers two notifiers: one to catch throttle
> messages from the OCC and one to bump the CPU frequency back to normal
> before a reboot. Both require the cpufreq driver to be registered in order
> to function since the notifier callbacks use various cpufreq_*() functions.
> 
> Right now we register both notifiers before we've initialised the driver.
> This seems to work, but we should head off any protential problems by
> registering the notifiers after the driver is initialised.
> 
> Cc: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>

Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

> ---
>  drivers/cpufreq/powernv-cpufreq.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> index 1806b1d..03798c4 100644
> --- a/drivers/cpufreq/powernv-cpufreq.c
> +++ b/drivers/cpufreq/powernv-cpufreq.c
> @@ -1114,9 +1114,6 @@ static int __init powernv_cpufreq_init(void)
>  	if (rc)
>  		goto out;
> 
> -	register_reboot_notifier(&powernv_cpufreq_reboot_nb);
> -	opal_message_notifier_register(OPAL_MSG_OCC, &powernv_cpufreq_opal_nb);
> -
>  	if (powernv_pstate_info.wof_enabled)
>  		powernv_cpufreq_driver.boost_enabled = true;
>  	else
> @@ -1125,15 +1122,17 @@ static int __init powernv_cpufreq_init(void)
>  	rc = cpufreq_register_driver(&powernv_cpufreq_driver);
>  	if (rc) {
>  		pr_info("Failed to register the cpufreq driver (%d)\n", rc);
> -		goto cleanup_notifiers;
> +		goto cleanup;
>  	}
> 
>  	if (powernv_pstate_info.wof_enabled)
>  		cpufreq_enable_boost_support();
> 
> +	register_reboot_notifier(&powernv_cpufreq_reboot_nb);
> +	opal_message_notifier_register(OPAL_MSG_OCC, &powernv_cpufreq_opal_nb);
> +
>  	return 0;
> -cleanup_notifiers:
> -	unregister_all_notifiers();
> +cleanup:
>  	clean_chip_info();
>  out:
>  	pr_info("Platform driver disabled. System does not support PState control\n");
> -- 
> 2.9.5
> 

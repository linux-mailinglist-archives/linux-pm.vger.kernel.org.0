Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 411C2339BAB
	for <lists+linux-pm@lfdr.de>; Sat, 13 Mar 2021 05:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbhCMEG3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Mar 2021 23:06:29 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:59590 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233114AbhCMEGS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Mar 2021 23:06:18 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12D460i3113459;
        Sat, 13 Mar 2021 04:06:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=6kd27h98AHaRxlipZxnz+a1Q9TQw2wgh32cu22YPvrU=;
 b=bQzlR4HHLLfimTygWPGvtFQzz1iMZlFeD7WkSYuTcb3YbOkNmBdCldm+M/RZ/6IPwmBP
 IjBP4Hqf66nENo/EJn3LuQUwYOmD6UdZ1ZsNQAZvTW+3i6bG508GTK9eDqmlPgxpN8Yp
 1B6cyKUqe4dcqCjLKDRw6TAJMX/qDk0374t6B2nNft64YGyq65IoX2hywKpD4d6VcAEz
 axPUhVGaPBO/NvOE7r6D05JDTqee9bchx0qvl8zyci0Ecvitah0kRB9Sxx/cdrlE8QwM
 OkuDnDFARm4N5i/THmbeSj97clD8sQpys7OZkyHQefkgIPK84LHaBqJd9Zr5G0BA/ydm AQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 378jwb85r3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 13 Mar 2021 04:06:00 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12D40lIU065917;
        Sat, 13 Mar 2021 04:05:59 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by userp3020.oracle.com with ESMTP id 378mqj3cg0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 13 Mar 2021 04:05:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dYaZiKrD30e1qJZ73hZ32ixmx2KpFa9aCCKVD6xCuq0V2zTJ651w33bLl2QWjjTjo7z8cs2nK38Nlr/9TvvIRBeEb14fiNZhenNsJ0Pl0KMCPWVDleRuQzE4E4x8EiIiWU5DvcJMKemOg5Qkke/CKtbU0lAxZsG/D1F68Z7UVOySsoGaxuneSzyiPRE6ecDv5q7f4ZERKkSoqrXRVg1S7oBDD8aXr2GJMQrRlwfPzfEriwbaPeqIQw762aMlSv1J71zDlvWMYciv1PXUWn/tGywpIqhXfeIS6tJk6JYztWXJo+BVdPna3FDQB0fR0ORM/BNRRiIqqDTGLZHDruykeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6kd27h98AHaRxlipZxnz+a1Q9TQw2wgh32cu22YPvrU=;
 b=ZLJUmiOnTewRwJopwRLE12Tw3P7XyGApUXAQlrRMNZYhLLvlJW9txEUWHj1ogLaxb69Di8ja379NQSHGWfEYAnBkxT2KmGQD7C/9+MnCdwnQLXd7QE2mTy2G+uOxVWLElrc4y+1pPHMga5lmITDsdbLB6fmczgu8vZrF6IWA9x0d4EyY0nRFx/rMLRKjBgsQPwDvs6oSg07o2aIau4B7TGFLYX0pWUo7fLcMgH+XywFIqTO7qGOkQLADWJieDDx8znbZVK5ZkKxzlhZiVYfQic66LdU0q+IaJY4xqgS5F7UQcQwzMM7svR60irNGfWWYAmRC4GPf/EIfY090HzjT+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6kd27h98AHaRxlipZxnz+a1Q9TQw2wgh32cu22YPvrU=;
 b=YZi6k6c4nGFRDYoRxdtJlgMrekPqLHrUjG4u+8H2cc3LD9Av/spJRkbwHDefv1aX6CGRK0vm3Atl2Js9sqytpowJksn8yA/vCxqop2eQaISphK4xX3uSa5AiHfaPJFl7wKQpHkLWJ4Kr5dZLtVDeANMzRyoZuZVpxKNhngJUCdU=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB3794.namprd10.prod.outlook.com (2603:10b6:a03:1b2::30)
 by SJ0PR10MB4543.namprd10.prod.outlook.com (2603:10b6:a03:2d9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Sat, 13 Mar
 2021 04:05:57 +0000
Received: from BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::21a6:5c60:cd6e:1902]) by BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::21a6:5c60:cd6e:1902%7]) with mapi id 15.20.3912.031; Sat, 13 Mar 2021
 04:05:57 +0000
Date:   Fri, 12 Mar 2021 21:05:54 -0700
From:   Tom Saeger <tom.saeger@oracle.com>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org, krzk@kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
Subject: Re: [PATCH V3] cpufreq: Rudimentary typos fix in the file
 s5pv210-cpufreq.c
Message-ID: <20210313040554.t7qupskk2svtf6h4@brm-x62-17.us.oracle.com>
References: <20210313034951.13269-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210313034951.13269-1-unixbhaskar@gmail.com>
X-Originating-IP: [129.157.69.41]
X-ClientProxiedBy: SJ0PR03CA0321.namprd03.prod.outlook.com
 (2603:10b6:a03:39d::26) To BY5PR10MB3794.namprd10.prod.outlook.com
 (2603:10b6:a03:1b2::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brm-x62-17.us.oracle.com (129.157.69.41) by SJ0PR03CA0321.namprd03.prod.outlook.com (2603:10b6:a03:39d::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32 via Frontend Transport; Sat, 13 Mar 2021 04:05:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7bf42b4-8164-40e7-3bcb-08d8e5d54dbd
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4543:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB45437BD0A77ACA4133F8A071FC6E9@SJ0PR10MB4543.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hwvmY1zvwr5A4UVYrDqAJN45OfgrVVu9rTPAkBL+SZu34Sjd8U97LsxRSK98iVh68gXYlnL7Pr3GfEgaNkNtj8eMA6+SrhWUTV7Abae+IEVnxoNxAiv1GJ1NvWsXMCkz1tzmClMs+cCAARzcA1RxtCI+K6ofIGaAH32+YnJb9X5fChSbfYbuWo35BLWRe0jku/oUMo4kAvPzf+pOcBA5IRkyAiOMMrWPve/5gEK63BJEE3vyccqAYpX7rHYFeouRQBtDIaLGziPjq5e9I+FlriQw8YxEWM82e203adwJEQMMtnrO6iOQJxEB5sUjpG6L0IyNP2Md0nYm1r9rHqqs6mh/TYptJitChU28ymqxBaQ4D8Hmm0K1DRfMFjojMMPLmzwOpRz0fM+k7esJasyQw8RQuPNIQXFgOiR4GItwev2Edd3B3IMfi+ovWwA3QvOwICrOPj670vQ04S41fbHDZV/mfYH5W+YhaQpOAQSqe/sR+w8NY8EkgLU7ke+DmZ3I9Dk4LUPuLXATMgZTEnt9JbYohN9gzmxnb9hoOIw6pOlOn/TyYNpR2ENm2xFPGhaILTbMG3/GfvWDPHvN05PC1aRenkvY0ItOLFkT5JZbjmYqoPk5+/5bWrzWDmMWyqCn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3794.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(396003)(376002)(366004)(346002)(83380400001)(26005)(66946007)(186003)(956004)(44832011)(8676002)(66476007)(6916009)(2906002)(16526019)(966005)(5660300002)(1076003)(8936002)(7696005)(316002)(4326008)(478600001)(66556008)(55016002)(52116002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?imwoZCZDlyUwzIvX//E4k3p66O81jogM+7+1v66STgVHefboD7ypIZvIecI4?=
 =?us-ascii?Q?jiRPSgdS1ipt5E60sjK0c04ZnXT3NmsPTcyt6TVLwWGeX3MAzB5RBOW+CmyX?=
 =?us-ascii?Q?nq6i5/jGBmRNF+PNVlcJgFfDAVElYEMY5Z9rJyvDYEImo2q3zU6Htot7+FXn?=
 =?us-ascii?Q?hWl2DSDArsi8eLuiGiUomSyMNb6zlzMGDAKwiSYRa4ZdOyGjxas01gCwJ3zn?=
 =?us-ascii?Q?R4n1aKDsRiHXaGcjLkt+orbCfVK3wcN1c0TRUGtsXEo8+FbkLR0kEbB07tZw?=
 =?us-ascii?Q?UmzXgG8UG3VnGQR6wHijC27MvqHgnMyuiG3m5nyupv7effqyo0+2YmqugVpt?=
 =?us-ascii?Q?sPTEQsHiBASYN5raOh74NLdz8bY92lRDSnUsFY1g44z4hX1NEa315hxEB6w9?=
 =?us-ascii?Q?stXSv1pD46Aa0TGD91LValAtvwXoGpZcQoiJ3eaI+78qwIf6XziKEX02Red7?=
 =?us-ascii?Q?0RlypbVX4DmjSpRdMDBCCeQXAZhihjajgiJc/f4FLs7HHJ7kxZ5+jQOzVxnJ?=
 =?us-ascii?Q?SWbZXHedtFAUJDJFNWF5f+LqTj80Nns3GLUMUeW/t8AtmWQXQnZBmYncHDhz?=
 =?us-ascii?Q?Ubk7B+AeK8G1nZ9HdvZkDeOzQpvY3g8xiyJj2aPXALKO1R8o35XBj4wxNj6n?=
 =?us-ascii?Q?UyFxtWAY/KWtLlHRQogv7fGLWugpnZWPG/5vJqZH5Elb85qg1c4WIeCX0pz4?=
 =?us-ascii?Q?hbAMZK1s2Ig54UCsXN2wmErQ4MGutYK/WO3x0T3iwulmnRsfFRjnv69xuwot?=
 =?us-ascii?Q?lEnlEZjvf1HCLZiqXk4hkXVV0t4Gr8iieuqILxD0f3lhBRWDeyCpz9R76iRM?=
 =?us-ascii?Q?aCk1CIxFCYNJfBIhu0HzS4GCmU4DI0KQ1XaSB2TiQPpMNp4rPTbSM96Qtxgh?=
 =?us-ascii?Q?YBZZR2VHHgJssQXrL8l1V4AGrdvw0OQ5p/AqyddjT70fiSKmO6DVSdhziFG/?=
 =?us-ascii?Q?UfzUbi2a20T4ZRxDiAjW34BpQSgWo3P9mYrZWb2eYR+SahxXrl5lBVyLPz6a?=
 =?us-ascii?Q?3ms8C21qECl/wkvGfe+DxN85Vr7WOLmYoNqCPwolPMKGBtWwtdeMPQ/DdXNP?=
 =?us-ascii?Q?dt21k9BhYJOLLZzofFunbLaJq4agRNzUYbMTNWalpQLmjypzKTlBZm9BR0zn?=
 =?us-ascii?Q?7II0n0to4VL5grn9grZkpkclD9ufsrTl7zxNrdU5cRtiOgkjXojfjPwwQy49?=
 =?us-ascii?Q?6L2eIyzQQDkpxQ7iS07iDulmRe67Lk4sAl6KbkikBBK5baaf8y3vkajegjM6?=
 =?us-ascii?Q?vIxNOz9IbZkDDSgj+wzGVHFhJNHy/LWxyWZv9jz6p3B+OAEUHl38dAvvlKlG?=
 =?us-ascii?Q?1MYJLU3K19U2otAnIxwjraWb?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7bf42b4-8164-40e7-3bcb-08d8e5d54dbd
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3794.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2021 04:05:57.0875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cEccATO3Dtw0fvQ1DwalaIqiUV01RJntZQhMF67lFa+rUDvkA0B2rFyvbDnyCkEe5Wd+g6Gl76rTENX8+5J2Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4543
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9921 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0 phishscore=0
 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103130024
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9921 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103130024
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Mar 13, 2021 at 09:19:51AM +0530, Bhaskar Chowdhury wrote:
> 
> Trivial spelling fixes throughout the file.
> 

LGTM

Reviewed-by: Tom Saeger <tom.saeger@oracle.com>

> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  Changes from V2:
>   Incoporated the findings of Tom Saeger <tom.saeger@oracle.com>
> 
>  drivers/cpufreq/s5pv210-cpufreq.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
> index 69786e5bbf05..73110b005716 100644
> --- a/drivers/cpufreq/s5pv210-cpufreq.c
> +++ b/drivers/cpufreq/s5pv210-cpufreq.c
> @@ -91,7 +91,7 @@ static DEFINE_MUTEX(set_freq_lock);
>  /* Use 800MHz when entering sleep mode */
>  #define SLEEP_FREQ	(800 * 1000)
> 
> -/* Tracks if cpu freqency can be updated anymore */
> +/* Tracks if cpu frequency can be updated anymore */
>  static bool no_cpufreq_access;
> 
>  /*
> @@ -190,7 +190,7 @@ static u32 clkdiv_val[5][11] = {
> 
>  /*
>   * This function set DRAM refresh counter
> - * accoriding to operating frequency of DRAM
> + * according to operating frequency of DRAM
>   * ch: DMC port number 0 or 1
>   * freq: Operating frequency of DRAM(KHz)
>   */
> @@ -320,7 +320,7 @@ static int s5pv210_target(struct cpufreq_policy *policy, unsigned int index)
> 
>  		/*
>  		 * 3. DMC1 refresh count for 133Mhz if (index == L4) is
> -		 * true refresh counter is already programed in upper
> +		 * true refresh counter is already programmed in upper
>  		 * code. 0x287@83Mhz
>  		 */
>  		if (!bus_speed_changing)
> @@ -378,7 +378,7 @@ static int s5pv210_target(struct cpufreq_policy *policy, unsigned int index)
>  		/*
>  		 * 6. Turn on APLL
>  		 * 6-1. Set PMS values
> -		 * 6-2. Wait untile the PLL is locked
> +		 * 6-2. Wait until the PLL is locked
>  		 */
>  		if (index == L0)
>  			writel_relaxed(APLL_VAL_1000, S5P_APLL_CON);
> @@ -390,7 +390,7 @@ static int s5pv210_target(struct cpufreq_policy *policy, unsigned int index)
>  		} while (!(reg & (0x1 << 29)));
> 
>  		/*
> -		 * 7. Change souce clock from SCLKMPLL(667Mhz)
> +		 * 7. Change source clock from SCLKMPLL(667Mhz)
>  		 * to SCLKA2M(200Mhz) in MFC_MUX and G3D MUX
>  		 * (667/4=166)->(200/4=50)Mhz
>  		 */
> @@ -439,7 +439,7 @@ static int s5pv210_target(struct cpufreq_policy *policy, unsigned int index)
>  	}
> 
>  	/*
> -	 * L4 level need to change memory bus speed, hence onedram clock divier
> +	 * L4 level needs to change memory bus speed, hence onedram clock divider
>  	 * and memory refresh parameter should be changed
>  	 */
>  	if (bus_speed_changing) {
> --
> 2.26.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

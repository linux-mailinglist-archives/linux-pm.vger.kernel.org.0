Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC17824C648
	for <lists+linux-pm@lfdr.de>; Thu, 20 Aug 2020 21:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbgHTTdK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Aug 2020 15:33:10 -0400
Received: from mail-mw2nam10on2062.outbound.protection.outlook.com ([40.107.94.62]:26144
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725977AbgHTTdH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 20 Aug 2020 15:33:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kt+nfsh03aVdbU5S5LGoodn+djN0brIvf/jskK5ztUHMMA7fMSGgqj8MRMx0c6wQJzTfy91OwUYXQ7PqN94t1hoaox2Ub+7vwHI2wkLfRHc9F3Z9cYcTZIYeabWcAWe+T/PoW33CUvaWRx+EwFynngCRrCQopNmXUU86WJpvQ5szaJ5Pz1dQLQRlgotNRCYw6iVZOs42itux5/2qhuTm9MVKZ3WgHQwvyf5tB6cMm0kz8pof2ATEc7WYyupHV93/YttCE159s2o81BY61Zrkh+C3eOUboS6XT8SXG86lT5K1B46d1Agtgzlz28roU06syaJuU0pmIAR5EAeAiBeL2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PwJEvV5Mtbni4W3y0KFgCKJ/h7ue2guuOUgIG0+cqjU=;
 b=WQ2Cj/H9M7rS0xzy2W6TB3AhBL1qxoUdYKIL5g4A+jiZLBe5wPbPrWnUaJrLF1bsAG111jS9rizSCyxByhzLwS72vKr1aIwL+j8Igobv1gZpNkx3rAK+KMM7PO2f/xv/Lh3dGmBJHdMWfIpcGDu+8ZKR+svqMinCtWVLHUUKq9IAdmzR78hSXJlDByoNsq8CsfF+g0ntGc1GYlmaa06wUwq3/uBd8aQ3EqRh6Sen1ZPqlnA/gHUvDblDlR6cmlvjsj+en/Xs6AiJVkl/RRDFglYmBdNeCOsCIIZbsHeSBeKAsr31CzAA8VlFJFG2jdLH4Sq+CIfWvxVEvTqI+NikHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PwJEvV5Mtbni4W3y0KFgCKJ/h7ue2guuOUgIG0+cqjU=;
 b=m2kxStHUQG35ze8OSWopgYiVn8JlNS5HOejT5p6RUSjYYWf26hyhZ5EQv7s6XA7BM0sku7PoPJm8/sKyfOTea2XN50XqwsLRECLMpigUS7p0EGRvcWitUMjIfB35scf7q9DC7cRK5vKf3EfNoOQfZ9XBNyN1nEQtDN31KgnXnd8=
Authentication-Results: linux.vnet.ibm.com; dkim=none (message not signed)
 header.d=none;linux.vnet.ibm.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3804.namprd12.prod.outlook.com (2603:10b6:5:1cd::22)
 by DM6PR12MB4466.namprd12.prod.outlook.com (2603:10b6:5:2ae::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16; Thu, 20 Aug
 2020 19:33:05 +0000
Received: from DM6PR12MB3804.namprd12.prod.outlook.com
 ([fe80::c0d5:d8fd:6f66:9149]) by DM6PR12MB3804.namprd12.prod.outlook.com
 ([fe80::c0d5:d8fd:6f66:9149%7]) with mapi id 15.20.3305.025; Thu, 20 Aug 2020
 19:33:05 +0000
Subject: Re: [RFC] cpuidle : Add support for pseudo-cpuidle driver
To:     Abhishek Goel <huntbag@linux.vnet.ibm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rjw@rjwysocki.net, daniel.lezcano@linaro.org, mpe@ellerman.id.au,
        ego@linux.vnet.ibm.com
References: <20200723061339.9747-1-huntbag@linux.vnet.ibm.com>
From:   "Fontenot, Nathan" <Nathan.Fontenot@amd.com>
Message-ID: <c0a8b652-04d2-c350-87ac-4f899c7e2135@amd.com>
Date:   Thu, 20 Aug 2020 14:33:02 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <20200723061339.9747-1-huntbag@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR13CA0061.namprd13.prod.outlook.com
 (2603:10b6:3:117::23) To DM6PR12MB3804.namprd12.prod.outlook.com
 (2603:10b6:5:1cd::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by DM5PR13CA0061.namprd13.prod.outlook.com (2603:10b6:3:117::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.10 via Frontend Transport; Thu, 20 Aug 2020 19:33:04 +0000
X-Originating-IP: [165.204.77.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 209ce1e3-a408-4e94-a25c-08d8453fdc0b
X-MS-TrafficTypeDiagnostic: DM6PR12MB4466:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4466338E860EF9130CADC362EC5A0@DM6PR12MB4466.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JqORtb+U/CGFbUOK/TvlmnAjdc7QBM2MrvHmEScF7DQmR9/u5pzpphMW77CpVjvz8+FOYFF9pZVj8o5h+Il+LBKxU04O0ciU52Vza5e0bw/rjzBjz9zCJeRBfLhQnwcBzn4ger39AqA6xbODcMck9tdphinzHwIQ6kS+3v3lzgLNUI6mr5OxxcnHxvryjgMrxa9pwD0+6Ck5R+JmgYKdcoaGabH4IA6olRSuaUbXl9GywyDCcVeZvO8WV0pTtoen9oOfeBL7CvpC+8OdW14Qixk72rmIPL5im27mrc1/RU0oy0ZRDzEYA/m6TJ+65rblULr4B0wtGRImC1NdOoI+tXH5tjn2I75pK8nelYdJd27JFNOkYGtOSTBiqNtRcycREV7sdbcDITcVT73UBKxtddyKsxnIdxHeDwMN2z38/jtP2aeLAYwMj+OOI2hoAmNIwMkBz4om9MR7BbAue5zMcOVyg28LPmL2PUS226MQA1o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3804.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(376002)(396003)(346002)(2616005)(26005)(4326008)(478600001)(52116002)(8936002)(6486002)(966005)(36756003)(45080400002)(66476007)(86362001)(66556008)(8676002)(83380400001)(110011004)(5660300002)(186003)(31686004)(31696002)(16576012)(2906002)(956004)(53546011)(66946007)(316002)(30864003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: rqE3ac1kzcP+ydRXjPtKRCSqfJITMuC0jE2glfXL9s3MztjLepyIm3zEw/C4b6CnAuhdKLnLHvGklQXX6JsRIBdbApEYHRtFlqVEHh/ibHf6K60viZXFNZI1yNjVz1lH13WcIKn+FfnP1xcCOE1Th8ZoczZuGS2LkzdFg4ZucPs3wIx6f93G4T4wWNvmWo8X0f3XMFacfCG1++vBMvX1wK/Hi85TM2GfEYVqBnRgG88w0HK8eU0OxJLA8N8IE5M+tY5rDomQS6pjABgRYBwsz8DH9p4xmVbdZ0fPbDanRkhW0qJnCZ+fp8ca4QOOCV7s+cAuavaiO1sN5NfGkjGsUc/U5DH0dWMZ8E1NQ8bO8ghD/bjn97EELVZ83imqd06xPpD0ok9cKwCbwhqP+2o5YOE3x0Q37jP7REhxFxSepy/s+yGpgV+Cxfy9Tr5nVS6kHknKlGIOPmMJexfU5i0UfLml66tkJ7uBU6JzkPX4T1A08FfEuQixZGrM71fAZSF/aCpc+W03sOS0LZWDltrJnQzmVzsTzZjL6MqnvXBqS+r2Yh8HJ35UAIQa6pBHY3CtBicLzYOhXO/HOWA1u7rYIykXaThfFixI2iSeDhqwJPaKGX4xInHLNzq1yubpNoGS+ygmij7QhoZxKWrYW2Fchw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 209ce1e3-a408-4e94-a25c-08d8453fdc0b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 19:33:05.2719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ek+xaOiszXZauTL0fZvIi1HrQSOiRtlO9wb2mNmbFDc2zq88FZ3g8Q3PmixK5DkZ5lxDGzivh4ylZU2qfFthOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4466
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 7/23/2020 1:13 AM, Abhishek Goel wrote:
> This option adds support for a testing cpuidle driver, which allows
> user to define custom idle states with their respective latencies and
> residencies. This is useful for testing the behaviour of governors on
> customized set of idle states.
> 
> This can be used as of now by hard-coding the customized set of cpuidle
> states in the driver. Will add the capability of this driver to be used
> as a module in subsequent patches.
> 
> Original idea and discussion for this patch can be found at:
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.org%2Flkml%2F2019%2F12%2F17%2F655&amp;data=02%7C01%7CNathan.Fontenot%40amd.com%7C25e5be70d73e4027242208d82ed0096b%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637310818339452963&amp;sdata=mO%2BOhH%2BoDiYJJDHUfF%2BFVtgzBAO8H%2FcaiqWACJOxtmE%3D&amp;reserved=0
> 
> Signed-off-by: Abhishek Goel <huntbag@linux.vnet.ibm.com>
> ---

A couple of thoughts after getting a chance to play around with this on AMD
systems. Once I added C-states for AMD systems andd moved the driver (see below)
everything works as expected. One issue I do see is that boot is really slow
one the system I'm using. I haven't had a chance to look into why but will
let you know if it's related to the driver.

For this to work on x86 I believe you'll need to have the driver
live in drivers/idle instead of drivers/cpuidle. With ACPI you can only register
one idle driver and the first one to register is set as the driver. Moving
this to drivers/idle allows the psuedo-cpuidle driver to register before the
acpi-idle driver. Introducing a boot option to enable the psuedo-idle driver
would also help by allowing you to build the driver into the kernel and allow
you to boot into the default idle driver.

When selecting the C-state tables to use (sim_type=X) I think you could
use the existing acpi routines to read the C-states directly from the
ACPI tables and then just update the .idle routine pointer. This should
allow the driver to work on any x86 system without having to update
the driver code.

-Nathan

>  drivers/cpuidle/Kconfig        |   9 ++
>  drivers/cpuidle/Makefile       |   1 +
>  drivers/cpuidle/cpuidle-test.c | 276 +++++++++++++++++++++++++++++++++
>  3 files changed, 286 insertions(+)
>  create mode 100644 drivers/cpuidle/cpuidle-test.c
> 
> diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
> index c0aeedd66f02..1d73153a0e35 100644
> --- a/drivers/cpuidle/Kconfig
> +++ b/drivers/cpuidle/Kconfig
> @@ -71,6 +71,15 @@ config HALTPOLL_CPUIDLE
>  	 before halting in the guest (more efficient than polling in the
>  	 host via halt_poll_ns for some scenarios).
>  
> +config TEST_CPUIDLE
> +	tristate "cpuidle test driver"
> +	default m
> +	help
> +	 This option enables a testing cpuidle driver, which allows to user
> +	 to define custom idle states with their respective latencies and residencies.
> +	 This is useful for testing the behaviour of governors on different
> +	 set of idle states.
> +
>  endif
>  
>  config ARCH_NEEDS_CPU_IDLE_COUPLED
> diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
> index f07800cbb43f..68ea7dc257b5 100644
> --- a/drivers/cpuidle/Makefile
> +++ b/drivers/cpuidle/Makefile
> @@ -8,6 +8,7 @@ obj-$(CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED) += coupled.o
>  obj-$(CONFIG_DT_IDLE_STATES)		  += dt_idle_states.o
>  obj-$(CONFIG_ARCH_HAS_CPU_RELAX)	  += poll_state.o
>  obj-$(CONFIG_HALTPOLL_CPUIDLE)		  += cpuidle-haltpoll.o
> +obj-$(CONFIG_TEST_CPUIDLE)		  += cpuidle-test.o
>  
>  ##################################################################################
>  # ARM SoC drivers
> diff --git a/drivers/cpuidle/cpuidle-test.c b/drivers/cpuidle/cpuidle-test.c
> new file mode 100644
> index 000000000000..399729440569
> --- /dev/null
> +++ b/drivers/cpuidle/cpuidle-test.c
> @@ -0,0 +1,276 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *  cpuidle-test - Test driver for cpuidle.
> + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/moduleparam.h>
> +#include <linux/cpuidle.h>
> +#include <linux/cpu.h>
> +#include <linux/module.h>
> +#include <linux/sched/idle.h>
> +#include <linux/sched/clock.h>
> +#include <linux/sched/idle.h>
> +
> +#define CPUIDLE_STATE_MAX	10
> +#define MAX_PARAM_LENGTH	100
> +
> +static unsigned int nr_states = 4;
> +static unsigned int sim_type = 1;
> +static char name[MAX_PARAM_LENGTH];
> +static char latency_us[MAX_PARAM_LENGTH];
> +static char residency_us[MAX_PARAM_LENGTH];
> +
> +
> +module_param(nr_states, uint, 0644);
> +module_param(sim_type, uint, 0644);
> +module_param_string(name, name, MAX_PARAM_LENGTH, 0644);
> +module_param_string(latency_us, latency_us, MAX_PARAM_LENGTH, 0644);
> +module_param_string(residency_us, residency_us, MAX_PARAM_LENGTH, 0644);
> +
> +static struct cpuidle_driver test_cpuidle_driver = {
> +	.name		= "test_cpuidle",
> +	.owner		= THIS_MODULE,
> +};
> +
> +static struct cpuidle_state *cpuidle_state_table __read_mostly;
> +
> +static struct cpuidle_device __percpu *test_cpuidle_devices;
> +static enum cpuhp_state test_hp_idlestate;
> +
> +
> +static int __cpuidle idle_loop(struct cpuidle_device *dev,
> +				struct cpuidle_driver *drv,
> +				int index)
> +{
> +	u64 time_start;
> +
> +	local_irq_enable();
> +	if (!current_set_polling_and_test()) {
> +		while (!need_resched())
> +			cpu_relax();
> +	}
> +
> +	time_start = local_clock();
> +
> +	while (local_clock() - time_start < drv->states[index].exit_latency)
> +
> +	current_clr_polling();
> +
> +	return index;
> +}
> +
> +static struct cpuidle_state cpuidle_states[CPUIDLE_STATE_MAX] = {
> +	{ /* Snooze */
> +		.name = "snooze",
> +		.exit_latency = 0,
> +		.target_residency = 0,
> +		.enter = idle_loop },
> +};
> +
> +static struct cpuidle_state cpuidle_states_ppc[] = {
> +	{	.name = "snooze",
> +		.exit_latency = 0,
> +		.target_residency = 0,
> +		.enter = idle_loop },
> +	{
> +		.name = "stop0",
> +		.exit_latency = 2,
> +		.target_residency = 20,
> +		.enter = idle_loop },
> +	{
> +		.name = "stop1",
> +		.exit_latency = 5,
> +		.target_residency = 50,
> +		.enter = idle_loop },
> +	{
> +		.name = "stop2",
> +		.exit_latency = 10,
> +		.target_residency = 100,
> +		.enter = idle_loop },
> +};
> +
> +static struct cpuidle_state cpuidle_states_intel[] = {
> +	{	.name = "poll",
> +		.exit_latency = 0,
> +		.target_residency = 0,
> +		.enter = idle_loop },
> +	{
> +		.name = "c1",
> +		.exit_latency = 2,
> +		.target_residency = 2,
> +		.enter = idle_loop },
> +	{
> +		.name = "c1e",
> +		.exit_latency = 10,
> +		.target_residency = 20,
> +		.enter = idle_loop },
> +	{
> +		.name = "c3",
> +		.exit_latency = 80,
> +		.target_residency = 211,
> +		.enter = idle_loop },
> +};
> +
> +int cpuidle_cpu_online(unsigned int cpu)
> +{
> +	struct cpuidle_device *dev;
> +
> +	dev = per_cpu_ptr(test_cpuidle_devices, cpu);
> +	if (!dev->registered) {
> +		dev->cpu = cpu;
> +		if (cpuidle_register_device(dev)) {
> +			pr_notice("cpuidle_register_device %d failed!\n", cpu);
> +			return -EIO;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +int cpuidle_cpu_dead(unsigned int cpu)
> +{
> +	struct cpuidle_device *dev;
> +
> +	dev = per_cpu_ptr(test_cpuidle_devices, cpu);
> +	if (dev->registered)
> +		cpuidle_unregister_device(dev);
> +
> +	return 0;
> +}
> +
> +int cpuidle_driver_init(void)
> +{
> +	int idle_state;
> +	struct cpuidle_driver *drv = &test_cpuidle_driver;
> +
> +	drv->state_count = 0;
> +
> +	for (idle_state = 0; idle_state < nr_states; ++idle_state) {
> +		/* Is the state not enabled? */
> +		if (cpuidle_state_table[idle_state].enter == NULL)
> +			continue;
> +
> +		drv->states[drv->state_count] =	/* structure copy */
> +			cpuidle_state_table[idle_state];
> +
> +		drv->state_count += 1;
> +	}
> +
> +	return 0;
> +}
> +
> +int add_cpuidle_states(void)
> +{
> +	/* Parse the module param and initialize the idle states here
> +	 * in cpuidle_state_table.
> +	 */
> +	char *this_param;
> +	char *input_name = name;
> +	char *input_res = residency_us;
> +	char *input_lat = latency_us;
> +	int index = 1;
> +	long temp;
> +	int rc;
> +
> +	switch (sim_type) {
> +	case 1:
> +		cpuidle_state_table = cpuidle_states_ppc;
> +		return 0;
> +	case 2:
> +		cpuidle_state_table = cpuidle_states_intel;
> +		return 0;
> +	case 3:
> +		break;
> +	default:
> +		pr_warn("Sim value out of bound\n");
> +		break;
> +	}
> +
> +	if (strnlen(input_name, MAX_PARAM_LENGTH)) {
> +		while ((this_param = strsep(&input_name, ",")) && index <= nr_states) {
> +			strcpy(cpuidle_states[index].name, this_param);
> +			cpuidle_states[index].enter = idle_loop;
> +			index++;
> +		}
> +	}
> +
> +	if (strnlen(input_res, MAX_PARAM_LENGTH)) {
> +		index = 1;
> +		while ((this_param = strsep(&input_res, ",")) && index <= nr_states) {
> +			rc = kstrtol(this_param, 10, &temp);
> +			cpuidle_states[index].target_residency = temp;
> +			index++;
> +		}
> +	}
> +
> +	if (strnlen(input_lat, MAX_PARAM_LENGTH)) {
> +		index = 1;
> +		while ((this_param = strsep(&input_lat, ",")) && index <= nr_states) {
> +			rc = kstrtol(this_param, 10, &temp);
> +			cpuidle_states[index].exit_latency = temp;
> +			index++;
> +		}
> +	}
> +
> +	cpuidle_state_table = cpuidle_states;
> +	return nr_states;
> +}
> +
> +void test_cpuidle_uninit(void)
> +{
> +	if (test_hp_idlestate)
> +		cpuhp_remove_state(test_hp_idlestate);
> +	cpuidle_unregister_driver(&test_cpuidle_driver);
> +
> +	free_percpu(test_cpuidle_devices);
> +	test_cpuidle_devices = NULL;
> +}
> +
> +int __init test_cpuidle_init(void)
> +{
> +	int retval;
> +
> +	add_cpuidle_states();
> +	cpuidle_driver_init();
> +	retval = cpuidle_register(&test_cpuidle_driver, NULL);
> +	if (retval) {
> +		printk(KERN_DEBUG "Registration of test driver failed.\n");
> +		return retval;
> +	}
> +
> +	test_cpuidle_devices = alloc_percpu(struct cpuidle_device);
> +	if (test_cpuidle_devices == NULL) {
> +		cpuidle_unregister_driver(&test_cpuidle_driver);
> +		return -ENOMEM;
> +	}
> +
> +	retval = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
> +					   "cpuidle/powernv:online",
> +					   cpuidle_cpu_online,
> +					   cpuidle_cpu_dead);
> +
> +	if (retval < 0) {
> +		test_cpuidle_uninit();
> +	} else {
> +		test_hp_idlestate = retval;
> +		retval = 0;
> +	}
> +
> +	return retval;
> +}
> +
> +void __exit test_cpuidle_exit(void)
> +{
> +	test_cpuidle_uninit();
> +}
> +
> +module_init(test_cpuidle_init);
> +module_exit(test_cpuidle_exit);
> +MODULE_DESCRIPTION("Test Cpuidle Driver");
> +MODULE_AUTHOR("Abhishek Goel");
> +MODULE_LICENSE("GPL");
> +
> 

Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 260631908D1
	for <lists+linux-pm@lfdr.de>; Tue, 24 Mar 2020 10:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgCXJOt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Mar 2020 05:14:49 -0400
Received: from mga12.intel.com ([192.55.52.136]:47302 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726129AbgCXJOs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 24 Mar 2020 05:14:48 -0400
IronPort-SDR: G8fVrJt+lV0OmyLFhQ5xM4tlQtuPi+fW3TlHQm/SWAjOn2u8uznfGd2isHtZeLET63PErm4qzH
 wTWRRC/mJgiA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2020 02:14:48 -0700
IronPort-SDR: kNQ92f9FRuWv7i7RaB0MouIEgIhECgkFsGVQ4lNnxru2+IuIa6eEX9llV2ihnjUxAjGgOVwKVl
 iy3ZAvsIbF3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,299,1580803200"; 
   d="scan'208";a="325855535"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001.jf.intel.com with ESMTP; 24 Mar 2020 02:14:39 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jGfdw-00CUDq-W9; Tue, 24 Mar 2020 11:14:41 +0200
Date:   Tue, 24 Mar 2020 11:14:40 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mazziesaccount@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mikko Mutanen <mikko.mutanen@fi.rohmeurope.com>,
        Markus Laine <markus.laine@fi.rohmeurope.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@suse.de>,
        Brendan Higgins <brendanhiggins@google.com>,
        Changbin Du <changbin.du@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Gow <davidgow@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, Gary Hook <Gary.Hook@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mikhail Zaslonko <zaslonko@linux.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Tal Gilboa <talgi@mellanox.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH v6 04/10] lib/test_linear_ranges: add a test for the
 'linear_ranges'
Message-ID: <20200324091440.GD1922688@smile.fi.intel.com>
References: <cover.1584977512.git.matti.vaittinen@fi.rohmeurope.com>
 <0f5400617480787b415a1955c914c05445c30028.1584977512.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f5400617480787b415a1955c914c05445c30028.1584977512.git.matti.vaittinen@fi.rohmeurope.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Mar 24, 2020 at 10:29:41AM +0200, Matti Vaittinen wrote:
>     Add a KUnit test for the linear_ranges helper.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
>  lib/Kconfig.debug        |  11 ++
>  lib/Makefile             |   1 +
>  lib/test_linear_ranges.c | 228 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 240 insertions(+)
>  create mode 100644 lib/test_linear_ranges.c
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 69def4a9df00..32f355db4163 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2053,6 +2053,17 @@ config LIST_KUNIT_TEST
>  
>  	  If unsure, say N.
>  
> +config LINEAR_RANGES_TEST
> +	tristate "KUnit test for linear_ranges"
> +	depends on KUNIT
> +	help
> +	  This builds the linear_ranges unit test, which runs on boot.
> +	  Tests the linear_ranges logic correctness.
> +	  For more information on KUnit and unit tests in general please refer
> +	  to the KUnit documentation in Documentation/dev-tools/kunit/.
> +
> +	  If unsure, say N.
> +
>  config TEST_UDELAY
>  	tristate "udelay test driver"
>  	help
> diff --git a/lib/Makefile b/lib/Makefile
> index 18c3d313872e..200aa1780f92 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -301,3 +301,4 @@ obj-$(CONFIG_OBJAGG) += objagg.o
>  
>  # KUnit tests
>  obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o
> +obj-$(CONFIG_LINEAR_RANGES_TEST) += test_linear_ranges.o
> diff --git a/lib/test_linear_ranges.c b/lib/test_linear_ranges.c
> new file mode 100644
> index 000000000000..676e0b8abcdd
> --- /dev/null
> +++ b/lib/test_linear_ranges.c
> @@ -0,0 +1,228 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KUnit test for the linear_ranges helper.
> + *
> + * Copyright (C) 2020, ROHM Semiconductors.
> + * Author: Matti Vaittinen <matti.vaittien@fi.rohmeurope.com>
> + */
> +#include <kunit/test.h>
> +
> +#include <linux/linear_range.h>
> +
> +/* First things first. I deeply dislike unit-tests. I have seen all the hell
> + * breaking loose when people who think the unit tests are "the silver bullet"
> + * to kill bugs get to decide how a company should implement testing strategy...
> + *
> + * Believe me, it may get _really_ ridiculous. It is tempting to think that
> + * walking through all the possible execution branches will nail down 100% of
> + * bugs. This may lead to ideas about demands to get certain % of "test
> + * coverage" - measured as line coverage. And that is one of the worst things
> + * you can do.
> + *
> + * Ask people to provide line coverage and they do. I've seen clever tools
> + * which generate test cases to test the existing functions - and by default
> + * these tools expect code to be correct and just generate checks which are
> + * passing when ran against current code-base. Run this generator and you'll get
> + * tests that do not test code is correct but just verify nothing changes.
> + * Problem is that testing working code is pointless. And if it is not
> + * working, your test must not assume it is working. You won't catch any bugs
> + * by such tests. What you can do is to generate a huge amount of tests.
> + * Especially if you were are asked to proivde 100% line-coverage x_x. So what
> + * does these tests - which are not finding any bugs now - do?
> + *
> + * They add inertia to every future development. I think it was Terry Pratchet
> + * who wrote someone having same impact as thick syrup has to chronometre.
> + * Excessive amount of unit-tests have this effect to development. If you do
> + * actually find _any_ bug from code in such environment and try fixing it...
> + * ...chances are you also need to fix the test cases. In sunny day you fix one
> + * test. But I've done refactoring which resulted 500+ broken tests (which had
> + * really zero value other than proving to managers that we do do "quality")...
> + *
> + * After this being said - there are situations where UTs can be handy. If you
> + * have algorithms which take some input and should produce output - then you
> + * can implement few, carefully selected simple UT-cases which test this. I've
> + * previously used this for example for netlink and device-tree data parsing
> + * functions. Feed some data examples to functions and verify the output is as
> + * expected. I am not covering all the cases but I will see the logic should be
> + * working.
> + *
> + * Here we also do some minor testing. I don't want to go through all branches
> + * or test more or less obvious things - but I want to see the main logic is
> + * working. And I definitely don't want to add 500+ test cases that break when
> + * some simple fix is done x_x. So - let's only add few, well selected tests
> + * which ensure as much logic is good as possible.

And why you not to dare to put this directly to KUnit documentation?

I think it's not a place (I mean this file) for a discussions like that. I have
in my life cases when tests help not to break working code during endless
(micro-)optimizations. We have real examples with bitmap API here when tests
were (and I believe still is) helpful.

But I leave this to decide by somebody who would like to take the change,
let democracy stay!

> + */
> +
> +/*
> + * Test Range 1:
> + * selectors:	2	3	4	5	6
> + * values (5):	10	20	30	40	50
> + *
> + * Test Range 2:
> + * selectors:	7	8	9	10
> + * values (4):	100	150	200	250
> + */
> +
> +#define RANGE1_MIN 10
> +#define RANGE1_MIN_SEL 2
> +#define RANGE1_STEP 10
> +
> +/* 2, 3, 4, 5, 6 */
> +static const unsigned int range1_sels[] = { RANGE1_MIN_SEL, RANGE1_MIN_SEL + 1,
> +					    RANGE1_MIN_SEL + 2,
> +					    RANGE1_MIN_SEL + 3,
> +					    RANGE1_MIN_SEL + 4 };
> +/* 10, 20, 30, 40, 50 */
> +static const unsigned int range1_vals[] = { RANGE1_MIN, RANGE1_MIN +
> +					    RANGE1_STEP,
> +					    RANGE1_MIN + RANGE1_STEP * 2,
> +					    RANGE1_MIN + RANGE1_STEP * 3,
> +					    RANGE1_MIN + RANGE1_STEP * 4 };
> +
> +#define RANGE2_MIN 100
> +#define RANGE2_MIN_SEL 7
> +#define RANGE2_STEP 50
> +
> +/*  7, 8, 9, 10 */
> +static const unsigned int range2_sels[] = { RANGE2_MIN_SEL, RANGE2_MIN_SEL + 1,
> +					    RANGE2_MIN_SEL + 2,
> +					    RANGE2_MIN_SEL + 3 };
> +/* 100, 150, 200, 250 */
> +static const unsigned int range2_vals[] = { RANGE2_MIN, RANGE2_MIN +
> +					    RANGE2_STEP,
> +					    RANGE2_MIN + RANGE2_STEP * 2,
> +					    RANGE2_MIN + RANGE2_STEP * 3 };
> +
> +#define RANGE1_NUM_VALS (ARRAY_SIZE(range1_vals))
> +#define RANGE2_NUM_VALS (ARRAY_SIZE(range2_vals))
> +#define RANGE_NUM_VALS (RANGE1_NUM_VALS + RANGE2_NUM_VALS)
> +
> +#define RANGE1_MAX_SEL (RANGE1_MIN_SEL + RANGE1_NUM_VALS - 1)
> +#define RANGE1_MAX_VAL (range1_vals[RANGE1_NUM_VALS - 1])
> +
> +#define RANGE2_MAX_SEL (RANGE2_MIN_SEL + RANGE2_NUM_VALS - 1)
> +#define RANGE2_MAX_VAL (range2_vals[RANGE2_NUM_VALS - 1])
> +
> +#define SMALLEST_SEL RANGE1_MIN_SEL
> +#define SMALLEST_VAL RANGE1_MIN
> +
> +static struct linear_range testr[] = {
> +	{
> +		.min = RANGE1_MIN,
> +		.min_sel = RANGE1_MIN_SEL,
> +		.max_sel = RANGE1_MAX_SEL,
> +		.step = RANGE1_STEP,
> +	}, {
> +		.min = RANGE2_MIN,
> +		.min_sel = RANGE2_MIN_SEL,
> +		.max_sel = RANGE2_MAX_SEL,
> +		.step = RANGE2_STEP
> +	},
> +};
> +
> +static void range_test_get_value(struct kunit *test)
> +{
> +	int ret, i;
> +	unsigned int sel, val;
> +
> +	for (i = 0; i < RANGE1_NUM_VALS; i++) {
> +		sel = range1_sels[i];
> +		ret = linear_range_get_value_array(&testr[0], 2, sel, &val);
> +		KUNIT_EXPECT_EQ(test, 0, ret);
> +		KUNIT_EXPECT_EQ(test, val, range1_vals[i]);
> +	}
> +	for (i = 0; i < RANGE2_NUM_VALS; i++) {
> +		sel = range2_sels[i];
> +		ret = linear_range_get_value_array(&testr[0], 2, sel, &val);
> +		KUNIT_EXPECT_EQ(test, 0, ret);
> +		KUNIT_EXPECT_EQ(test, val, range2_vals[i]);
> +	}
> +	ret = linear_range_get_value_array(&testr[0], 2, sel + 1, &val);
> +	KUNIT_EXPECT_NE(test, 0, ret);
> +}
> +
> +static void range_test_get_selector_high(struct kunit *test)
> +{
> +	int ret, i;
> +	unsigned int sel;
> +	bool found;
> +
> +	for (i = 0; i < RANGE1_NUM_VALS; i++) {
> +		ret = linear_range_get_selector_high(&testr[0], range1_vals[i],
> +						     &sel, &found);
> +		KUNIT_EXPECT_EQ(test, 0, ret);
> +		KUNIT_EXPECT_EQ(test, sel, range1_sels[i]);
> +		KUNIT_EXPECT_TRUE(test, found);
> +	}
> +
> +	ret = linear_range_get_selector_high(&testr[0], RANGE1_MAX_VAL + 1,
> +					     &sel, &found);
> +	KUNIT_EXPECT_LE(test, ret, 0);
> +
> +	ret = linear_range_get_selector_high(&testr[0], RANGE1_MIN - 1,
> +					     &sel, &found);
> +	KUNIT_EXPECT_EQ(test, 0, ret);
> +	KUNIT_EXPECT_FALSE(test, found);
> +	KUNIT_EXPECT_EQ(test, sel, range1_sels[0]);
> +}
> +
> +static void range_test_get_value_amount(struct kunit *test)
> +{
> +	int ret;
> +
> +	ret = linear_range_values_in_range_array(&testr[0], 2);
> +	KUNIT_EXPECT_EQ(test, (int)RANGE_NUM_VALS, ret);
> +}
> +
> +static void range_test_get_selector_low(struct kunit *test)
> +{
> +	int i, ret;
> +	unsigned int sel;
> +	bool found;
> +
> +	for (i = 0; i < RANGE1_NUM_VALS; i++) {
> +		ret = linear_range_get_selector_low_array(&testr[0], 2,
> +							  range1_vals[i], &sel,
> +							  &found);
> +		KUNIT_EXPECT_EQ(test, 0, ret);
> +		KUNIT_EXPECT_EQ(test, sel, range1_sels[i]);
> +		KUNIT_EXPECT_TRUE(test, found);
> +	}
> +	for (i = 0; i < RANGE2_NUM_VALS; i++) {
> +		ret = linear_range_get_selector_low_array(&testr[0], 2,
> +							  range2_vals[i], &sel,
> +							  &found);
> +		KUNIT_EXPECT_EQ(test, 0, ret);
> +		KUNIT_EXPECT_EQ(test, sel, range2_sels[i]);
> +		KUNIT_EXPECT_TRUE(test, found);
> +	}
> +
> +	/*
> +	 * Seek value greater than range max => get_selector_*_low should
> +	 * return Ok - but set found to false as value is not in range
> +	 */
> +	ret = linear_range_get_selector_low_array(&testr[0], 2,
> +					range2_vals[RANGE2_NUM_VALS - 1] + 1,
> +					&sel, &found);
> +
> +	KUNIT_EXPECT_EQ(test, 0, ret);
> +	KUNIT_EXPECT_EQ(test, sel, range2_sels[RANGE2_NUM_VALS - 1]);
> +	KUNIT_EXPECT_FALSE(test, found);
> +}
> +
> +static struct kunit_case range_test_cases[] = {
> +	KUNIT_CASE(range_test_get_value_amount),
> +	KUNIT_CASE(range_test_get_selector_high),
> +	KUNIT_CASE(range_test_get_selector_low),
> +	KUNIT_CASE(range_test_get_value),
> +	{},
> +};
> +
> +static struct kunit_suite range_test_module = {
> +	.name = "linear-ranges-test",
> +	.test_cases = range_test_cases,
> +};
> +
> +kunit_test_suites(&range_test_module);
> +
> +MODULE_LICENSE("GPL");
> -- 
> 2.21.0
> 
> 
> -- 
> Matti Vaittinen, Linux device drivers
> ROHM Semiconductors, Finland SWDC
> Kiviharjunlenkki 1E
> 90220 OULU
> FINLAND
> 
> ~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
> Simon says - in Latin please.
> ~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
> Thanks to Simon Glass for the translation =] 

-- 
With Best Regards,
Andy Shevchenko



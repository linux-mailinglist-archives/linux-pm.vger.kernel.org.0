Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4FC028BE9D
	for <lists+linux-pm@lfdr.de>; Mon, 12 Oct 2020 19:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403923AbgJLREp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Oct 2020 13:04:45 -0400
Received: from mail-dm6nam12on2072.outbound.protection.outlook.com ([40.107.243.72]:14977
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2403845AbgJLREp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 12 Oct 2020 13:04:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WQweAuPSI6+3YMswXhstSYp0gYFykiJpvbwycCO+rLuZvl8xVNuSaqcWX4HIf2B30Jcd27IlKIst7ECuhopLEKGibppv6YYx6GoiYieYIpuqYlBfzSVzUfQtJS12Iu2hmGsLeFUPxy/Om9wj1ZQM7P1fh5RswhV65b3AUMSxfJye4qmSqCkQc50otPZVnjhX3YtuWous/LEbWUC9fUwz1UWzxuRX17UusqhKu5yFAN4rcucEcoKGCsZk9INdp1u24aSAnr0jGsM7PprfYeccMuNZlqJgU+wFBY2TFNx2Nbi8KyJXIPkqABhL0kjCUIfikRfBghz1FSUnB1JKaEAqog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FQ/DFQmZE5ZSsMPvaMr8LjRo7hj1IyeHUBNyuK3r81k=;
 b=j5QxskHErzRksotS8/533I+oqEMKr/MkfK5ofLd9v2ji+gZJyy0jYhWdZOQRPXaaDNqQtMoQPpsYawSWZhaj3KMv3QgZwZGkIw6ZOtSJhZG3YogOQadTZhOwh4S0BWG3AZ0xuRfTVimD48EheZzeFiuLt8zucsP4nPiNbaQdqs9jP7+6ka11Ma0+Z4XTjZJuTcoQxITDfE/wzDSJ3+24rODrRdozBn7H6z1sba/C9K5kSPGUhuOE7WmHsNs+PCiBfoX9MzJRflNjtgiqj+UQMkR8oApxHkz1npcNQpbCJseNmJHvcmW275+FFP2fWj8RYguviszKvzimjPkzgFUFtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FQ/DFQmZE5ZSsMPvaMr8LjRo7hj1IyeHUBNyuK3r81k=;
 b=pbwfGFId7Ieu3LbSXuvu9t7PU8YGykbNDSVxLuHf1EvoK3DPYAPCFER42jwDJW6LlPDAXM5knjs4w+npd3BjNFaUvmnzDDi1O5SxfPjtgREKZ1MCi9xx8DApv6yIa6CNFVukGvhhRsoourZ+sQd+KNbTFE26ksi8mjilwBrx7sY=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=labundy.com;
Received: from SN6PR08MB5517.namprd08.prod.outlook.com (2603:10b6:805:fb::32)
 by SN6PR08MB4093.namprd08.prod.outlook.com (2603:10b6:805:1e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.24; Mon, 12 Oct
 2020 17:04:42 +0000
Received: from SN6PR08MB5517.namprd08.prod.outlook.com
 ([fe80::c989:9cea:baa6:8254]) by SN6PR08MB5517.namprd08.prod.outlook.com
 ([fe80::c989:9cea:baa6:8254%7]) with mapi id 15.20.3455.029; Mon, 12 Oct 2020
 17:04:42 +0000
Date:   Mon, 12 Oct 2020 12:04:35 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] PM / sysfs: Add the ability to call PM operations
 manually
Message-ID: <20201012170435.GA7275@labundy.com>
References: <1602461364-17300-1-git-send-email-jeff@labundy.com>
 <CAJZ5v0jmnWxnpwHEV3k04_v4YV+oOAm7JE3OyMbKe-K18x8OsA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jmnWxnpwHEV3k04_v4YV+oOAm7JE3OyMbKe-K18x8OsA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [136.49.227.119]
X-ClientProxiedBy: DM6PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:5:40::14) To SN6PR08MB5517.namprd08.prod.outlook.com
 (2603:10b6:805:fb::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from labundy.com (136.49.227.119) by DM6PR03CA0001.namprd03.prod.outlook.com (2603:10b6:5:40::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21 via Frontend Transport; Mon, 12 Oct 2020 17:04:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 734957bb-7b66-4a40-c24c-08d86ed0e90a
X-MS-TrafficTypeDiagnostic: SN6PR08MB4093:
X-Microsoft-Antispam-PRVS: <SN6PR08MB40936125A981784490C8FEA8D3070@SN6PR08MB4093.namprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CoUNnePGRKo84c6jsWPQZE19WGAf9X8wjj1YdWj9h9MN0qA1T/c9rMGCqhg25k8uYKILtWsUTDGrb59tPKwH7NIZZIdz7/k/CImuJoVswq81Levb5iOVU7qgr08oiDXUBQ3D6Pd22I0ofBMYhYxZZTyphXw9p4u62TWCzCF7NDh9keTu3WPjXCS3McisK4OY7bCVPUuVO5g4eca3IdpVLyJji6FbeuSOxtRFk+O1RANtAEdQ9Gqhjvvv/MA9mmdzHiQHtUYremMpYKMw50KB7ioaNZA6G4o551TTzxaEEVjfKOPH33b42Tk3z2Y+ZwtjqZ+Joy2MmF/R09g1HVDVnw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR08MB5517.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(366004)(396003)(376002)(136003)(346002)(54906003)(316002)(186003)(6916009)(26005)(8936002)(55016002)(8886007)(16526019)(66946007)(7696005)(66556008)(5660300002)(66476007)(53546011)(33656002)(2906002)(478600001)(86362001)(8676002)(6666004)(52116002)(36756003)(2616005)(1076003)(83380400001)(956004)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: jsJD/JDpuAzvuBpmcScjiq9D+BCbFPW72PxsyOlImgi9eZQFdyuq8a2i4v1ntHflOJdLPzBY+ACKOkjgwoRYVViRQkNS+HPojU5ia9rS5kxvhSJZujVKzfkS/MiaRmermhk+R3inJ27jUuBsFKtzfbsW5Jl6VVURBOQ6oTEKAJhAQYWCNROskgPSUCAgNarsfO2/TtCwI+g9tTAv7Cn30ipzFT73DTCRcGgXHztN8f8Em1UVqcGt72Obmd4kBj4zhOUGGopiRimj7oXIRbi7bbNeD6UV2KFf4SuD24s/Nmvw3zJ83KwahC8pE39XWyLjHzklX9zoeWHLnAhX4mTxfKony/+zYMz2zDYBc2hYOQi8gvm4RHkl7TAsthAxbH5Vfdmn2gHbAYstXQmyAX+rf0ZhOpkjCYlDcC7tF14j3b8K0XQ2FX0ZaNyFjdTHYFh+yhZOQ3fdin3A2AqL68IGnbQ+6GBikNZ/cP1Tn+EG4wHQHgBVpyhf9+wo50uWlKuesEAfAalZ286S+1dTYI4e+umFZQSfEpATdDvCbL9hGYI3d1elQs2M2di+qwyMm6OG/plgfyh9dtWs4J3mrBcyVb/kEAWXmfWeJRkE4DaQidrxajBVnkH9sbaSzUxn3CVU+SXz/Yi6wljB8PfSTfkbbg==
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 734957bb-7b66-4a40-c24c-08d86ed0e90a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR08MB5517.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2020 17:04:41.9162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bj+l3n9pIO9eumH4ca/cR43vhsUJNH/1HvKsHyPxK+yZ+LD23/pxGGC3G2Kdd9ycD8qWEtdTZS1ZBtKfk9OdKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB4093
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

Thank you for taking a look.

On Mon, Oct 12, 2020 at 12:31:02PM +0200, Rafael J. Wysocki wrote:
> On Mon, Oct 12, 2020 at 2:09 AM Jeff LaBundy <jeff@labundy.com> wrote:
> >
> > During driver development, it's useful to be able to call a device's
> > suspend and resume operations for test purposes without having to
> > involve the rest of the PM subsystem. Such an ability would be handy
> > for measuring power consumption, checking interrupt function, etc.
> >
> > The PM subsystem does have debug hooks for limiting the scope of
> > suspend or excluding devices that shouldn't suspend, but there can be
> > overhead in configuring these hooks that is often inconvenient during
> > early bring-up.
> >
> > This patch introduces the pm_op_test attribute, to be used as follows
> > (random I2C client used as an example):
> >
> > 1. echo 'suspend' > /sys/bus/i2c/devices/1-0044/power/pm_op_test
> > 2. Measure power consumption at one's leisure, check wake-up interrupt
> >    behavior, etc.
> > 3. echo 'resume' > /sys/bus/i2c/devices/1-0044/power/pm_op_test
> 
> This is utterly incorrect.
> 
> In general, the suspend and resume callbacks specific to system-wide
> PM cannot be executed in the working state of the system safely.

I don't disagree that suspending some devices outside of PM's knowledge
can be dangerous; that's why it's presented as a debug option. But for
innocuous devices like keypads or LED controllers where all we're doing
is writing some registers to put that device in a low-power mode during
system-wide suspend, it seems OK for test purposes.

Here's an example: I need to test the register writes and sequencing
in my suspend callback. I can use pm_test to do something similar, but
by the time I've fumbled around with my oscilloscope probes or called a
co-worker to come look at my bench while the device of interest is in a
low-power state, the system has already resumed.

Furthermore a development system may have some other blocking issue that
prevents system-wide suspend from working. I talk to my current platform
with SSH and if I try to test my driver's suspend callback with pm_test,
the platform drops off the network presumably because the WLAN adapter
is suspending (and it doesn't come back, presumably because it doesn't
support runtime suspend in the first place). In many cases we need to get
a driver to a vendor faster than we can troubleshoot that problem.

Is there a way I can change the patch to make it more palatable? I'm also
happy to drop it; it has simply been handy for me to have locally so I
figured I'd share it.

> 
> Thanks!

Kind regards,
Jeff LaBundy

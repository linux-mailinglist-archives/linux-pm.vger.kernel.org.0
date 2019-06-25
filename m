Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9FA25517C
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2019 16:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730037AbfFYOV7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Jun 2019 10:21:59 -0400
Received: from mga09.intel.com ([134.134.136.24]:11384 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728252AbfFYOV4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 25 Jun 2019 10:21:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jun 2019 07:21:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,416,1557212400"; 
   d="scan'208";a="163999718"
Received: from syhu-mobl.ccr.corp.intel.com ([10.249.173.95])
  by orsmga003.jf.intel.com with ESMTP; 25 Jun 2019 07:21:48 -0700
Message-ID: <1561472500.19713.2.camel@intel.com>
Subject: Re: [PATCH v1 04/22] docs: thermal: convert to ReST
From:   Zhang Rui <rui.zhang@intel.com>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Arjan van de Ven <arjan@linux.intel.com>
Date:   Tue, 25 Jun 2019 22:21:40 +0800
In-Reply-To: <20190625105334.19ae5d12@coco.lan>
References: <cover.1560891322.git.mchehab+samsung@kernel.org>
         <23fafb70bfc9bd8b7f306f2502617d8f8794eae5.1560891322.git.mchehab+samsung@kernel.org>
         <1561470011.19713.1.camel@intel.com> <20190625105334.19ae5d12@coco.lan>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 二, 2019-06-25 at 10:53 -0300, Mauro Carvalho Chehab wrote:
> Em Tue, 25 Jun 2019 21:40:11 +0800
> Zhang Rui <rui.zhang@intel.com> escreveu:
> 
> > 
> > On 二, 2019-06-18 at 18:05 -0300, Mauro Carvalho Chehab wrote:
> > > 
> > > Rename the thermal documentation files to ReST, add an
> > > index for them and adjust in order to produce a nice html
> > > output via the Sphinx build system.
> > > 
> > > At its new index.rst, let's add a :orphan: while this is not
> > > linked
> > > to
> > > the main index.rst file, in order to avoid build warnings.
> > > 
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> > >   
> > Acked-by: Zhang Rui <rui.zhang@intel.com>
> > 
> > should I apply this patch or you have a separate tree for all these
> > changes?
> Feel free to apply it directly to your tree. The patches on this
> series are pretty much independent.
> 
okay, queued for 5.3-rc1.

thanks,
rui
> > 
> > 
> > thanks,
> > rui
> > > 
> > > ---
> > >  ...pu-cooling-api.txt => cpu-cooling-api.rst} |  39 +-
> > >  .../{exynos_thermal => exynos_thermal.rst}    |  47 +-
> > >  ...emulation => exynos_thermal_emulation.rst} |  66 +--
> > >  Documentation/thermal/index.rst               |  18 +
> > >  ...el_powerclamp.txt => intel_powerclamp.rst} | 177 +++----
> > >  .../{nouveau_thermal => nouveau_thermal.rst}  |  54 +-
> > >  ...ower_allocator.txt => power_allocator.rst} | 140 ++---
> > >  .../thermal/{sysfs-api.txt => sysfs-api.rst}  | 490
> > > ++++++++++++--
> > > ----
> > >  ...hermal => x86_pkg_temperature_thermal.rst} |  28 +-
> > >  MAINTAINERS                                   |   2 +-
> > >  include/linux/thermal.h                       |   4 +-
> > >  11 files changed, 665 insertions(+), 400 deletions(-)
> > >  rename Documentation/thermal/{cpu-cooling-api.txt => cpu-
> > > cooling-
> > > api.rst} (82%)
> > >  rename Documentation/thermal/{exynos_thermal =>
> > > exynos_thermal.rst}
> > > (67%)
> > >  rename Documentation/thermal/{exynos_thermal_emulation =>
> > > exynos_thermal_emulation.rst} (36%)
> > >  create mode 100644 Documentation/thermal/index.rst
> > >  rename Documentation/thermal/{intel_powerclamp.txt =>
> > > intel_powerclamp.rst} (76%)
> > >  rename Documentation/thermal/{nouveau_thermal =>
> > > nouveau_thermal.rst} (64%)
> > >  rename Documentation/thermal/{power_allocator.txt =>
> > > power_allocator.rst} (74%)
> > >  rename Documentation/thermal/{sysfs-api.txt => sysfs-api.rst}
> > > (66%)
> > >  rename Documentation/thermal/{x86_pkg_temperature_thermal =>
> > > x86_pkg_temperature_thermal.rst} (80%)
> > > 
> > > diff --git a/Documentation/thermal/cpu-cooling-api.txt
> > > b/Documentation/thermal/cpu-cooling-api.rst
> > > similarity index 82%
> > > rename from Documentation/thermal/cpu-cooling-api.txt
> > > rename to Documentation/thermal/cpu-cooling-api.rst
> > > index 7df567eaea1a..645d914c45a6 100644
> > > --- a/Documentation/thermal/cpu-cooling-api.txt
> > > +++ b/Documentation/thermal/cpu-cooling-api.rst
> > > @@ -1,5 +1,6 @@
> > > +=======================
> > >  CPU cooling APIs How To
> > > -===================================
> > > +=======================
> > >  
> > >  Written by Amit Daniel Kachhap <amit.kachhap@linaro.org>
> > >  
> > > @@ -8,40 +9,54 @@ Updated: 6 Jan 2015
> > >  Copyright (c)  2012 Samsung Electronics Co., Ltd(http://www.sams
> > > ung.
> > > com)
> > >  
> > >  0. Introduction
> > > +===============
> > >  
> > >  The generic cpu cooling(freq clipping) provides
> > > registration/unregistration APIs
> > >  to the caller. The binding of the cooling devices to the trip
> > > point
> > > is left for
> > >  the user. The registration APIs returns the cooling device
> > > pointer.
> > >  
> > >  1. cpu cooling APIs
> > > +===================
> > >  
> > >  1.1 cpufreq registration/unregistration APIs
> > > -1.1.1 struct thermal_cooling_device *cpufreq_cooling_register(
> > > -	struct cpumask *clip_cpus)
> > > +--------------------------------------------
> > > +
> > > +    ::
> > > +
> > > +	struct thermal_cooling_device
> > > +	*cpufreq_cooling_register(struct cpumask *clip_cpus)
> > >  
> > >      This interface function registers the cpufreq cooling device
> > > with the name
> > >      "thermal-cpufreq-%x". This api can support multiple
> > > instances of
> > > cpufreq
> > >      cooling devices.
> > >  
> > > -   clip_cpus: cpumask of cpus where the frequency constraints
> > > will
> > > happen.
> > > +   clip_cpus:
> > > +	cpumask of cpus where the frequency constraints will
> > > happen.
> > >  
> > > -1.1.2 struct thermal_cooling_device
> > > *of_cpufreq_cooling_register(
> > > -					struct cpufreq_policy
> > > *policy)
> > > +    ::
> > > +
> > > +	struct thermal_cooling_device
> > > +	*of_cpufreq_cooling_register(struct cpufreq_policy
> > > *policy)
> > >  
> > >      This interface function registers the cpufreq cooling device
> > > with
> > >      the name "thermal-cpufreq-%x" linking it with a device tree
> > > node, in
> > >      order to bind it via the thermal DT code. This api can
> > > support
> > > multiple
> > >      instances of cpufreq cooling devices.
> > >  
> > > -    policy: CPUFreq policy.
> > > +    policy:
> > > +	CPUFreq policy.
> > >  
> > > -1.1.3 void cpufreq_cooling_unregister(struct
> > > thermal_cooling_device
> > > *cdev)
> > > +
> > > +    ::
> > > +
> > > +	void cpufreq_cooling_unregister(struct
> > > thermal_cooling_device *cdev)
> > >  
> > >      This interface function unregisters the "thermal-cpufreq-%x"
> > > cooling device.
> > >  
> > >      cdev: Cooling device pointer which has to be unregistered.
> > >  
> > >  2. Power models
> > > +===============
> > >  
> > >  The power API registration functions provide a simple power
> > > model
> > > for
> > >  CPUs.  The current power is calculated as dynamic power (static
> > > power isn't
> > > @@ -65,9 +80,9 @@ For a given processor implementation the
> > > primary
> > > factors are:
> > >    variation.  In pathological cases this variation can be
> > > significant,
> > >    but typically it is of a much lesser impact than the factors
> > > above.
> > >  
> > > -A high level dynamic power consumption model may then be
> > > represented
> > > as:
> > > +A high level dynamic power consumption model may then be
> > > represented
> > > as::
> > >  
> > > -Pdyn = f(run) * Voltage^2 * Frequency * Utilisation
> > > +	Pdyn = f(run) * Voltage^2 * Frequency * Utilisation
> > >  
> > >  f(run) here represents the described execution behaviour and its
> > >  result has a units of Watts/Hz/Volt^2 (this often expressed in
> > > @@ -80,9 +95,9 @@ factors.  Therefore, in initial implementation
> > > that
> > > contribution is
> > >  represented as a constant coefficient.  This is a simplification
> > >  consistent with the relative contribution to overall power
> > > variation.
> > >  
> > > -In this simplified representation our model becomes:
> > > +In this simplified representation our model becomes::
> > >  
> > > -Pdyn = Capacitance * Voltage^2 * Frequency * Utilisation
> > > +	Pdyn = Capacitance * Voltage^2 * Frequency * Utilisation
> > >  
> > >  Where `capacitance` is a constant that represents an indicative
> > >  running time dynamic power coefficient in fundamental units of
> > > diff --git a/Documentation/thermal/exynos_thermal
> > > b/Documentation/thermal/exynos_thermal.rst
> > > similarity index 67%
> > > rename from Documentation/thermal/exynos_thermal
> > > rename to Documentation/thermal/exynos_thermal.rst
> > > index 9010c4416967..5bd556566c70 100644
> > > --- a/Documentation/thermal/exynos_thermal
> > > +++ b/Documentation/thermal/exynos_thermal.rst
> > > @@ -1,8 +1,11 @@
> > > +========================
> > >  Kernel driver exynos_tmu
> > > -=================
> > > +========================
> > >  
> > >  Supported chips:
> > > +
> > >  * ARM SAMSUNG EXYNOS4, EXYNOS5 series of SoC
> > > +
> > >    Datasheet: Not publicly available
> > >  
> > >  Authors: Donggeun Kim <dg77.kim@samsung.com>
> > > @@ -19,32 +22,39 @@ Temperature can be taken from the temperature
> > > code.
> > >  There are three equations converting from temperature to
> > > temperature
> > > code.
> > >  
> > >  The three equations are:
> > > -  1. Two point trimming
> > > +  1. Two point trimming::
> > > +
> > >  	Tc = (T - 25) * (TI2 - TI1) / (85 - 25) + TI1
> > >  
> > > -  2. One point trimming
> > > +  2. One point trimming::
> > > +
> > >  	Tc = T + TI1 - 25
> > >  
> > > -  3. No trimming
> > > +  3. No trimming::
> > > +
> > >  	Tc = T + 50
> > >  
> > > -  Tc: Temperature code, T: Temperature,
> > > -  TI1: Trimming info for 25 degree Celsius (stored at TRIMINFO
> > > register)
> > > +  Tc:
> > > +       Temperature code, T: Temperature,
> > > +  TI1:
> > > +       Trimming info for 25 degree Celsius (stored at TRIMINFO
> > > register)
> > >         Temperature code measured at 25 degree Celsius which is
> > > unchanged
> > > -  TI2: Trimming info for 85 degree Celsius (stored at TRIMINFO
> > > register)
> > > +  TI2:
> > > +       Trimming info for 85 degree Celsius (stored at TRIMINFO
> > > register)
> > >         Temperature code measured at 85 degree Celsius which is
> > > unchanged
> > >  
> > >  TMU(Thermal Management Unit) in EXYNOS4/5 generates interrupt
> > >  when temperature exceeds pre-defined levels.
> > >  The maximum number of configurable threshold is five.
> > > -The threshold levels are defined as follows:
> > > +The threshold levels are defined as follows::
> > > +
> > >    Level_0: current temperature > trigger_level_0 + threshold
> > >    Level_1: current temperature > trigger_level_1 + threshold
> > >    Level_2: current temperature > trigger_level_2 + threshold
> > >    Level_3: current temperature > trigger_level_3 + threshold
> > >  
> > > -  The threshold and each trigger_level are set
> > > -  through the corresponding registers.
> > > +The threshold and each trigger_level are set
> > > +through the corresponding registers.
> > >  
> > >  When an interrupt occurs, this driver notify kernel thermal
> > > framework
> > >  with the function exynos_report_trigger.
> > > @@ -54,24 +64,27 @@ it can be used to synchronize the cooling
> > > action.
> > >  TMU driver description:
> > >  -----------------------
> > >  
> > > -The exynos thermal driver is structured as,
> > > +The exynos thermal driver is structured as::
> > >  
> > >  					Kernel Core thermal
> > > framework
> > >  				(thermal_core.c, step_wise.c,
> > > cpu_cooling.c)
> > >  								
> > > ^
> > >  								
> > > |
> > >  								
> > > |
> > > -TMU configuration data -------> TMU Driver  <------> Exynos Core
> > > thermal wrapper
> > > -(exynos_tmu_data.c)	      (exynos_tmu.c)	   (exyno
> > > s_th
> > > ermal_common.c)
> > > -(exynos_tmu_data.h)	      (exynos_tmu.h)	   (exyno
> > > s_th
> > > ermal_common.h)
> > > +  TMU configuration data -----> TMU Driver  <----> Exynos Core
> > > thermal wrapper
> > > +  (exynos_tmu_data.c)	      (exynos_tmu.c)	   (exy
> > > nos_
> > > thermal_common.c)
> > > +  (exynos_tmu_data.h)	      (exynos_tmu.h)	   (exy
> > > nos_
> > > thermal_common.h)
> > >  
> > > -a) TMU configuration data: This consist of TMU register
> > > offsets/bitfields
> > > +a) TMU configuration data:
> > > +		This consist of TMU register offsets/bitfields
> > >  		described through structure
> > > exynos_tmu_registers.
> > > Also several
> > >  		other platform data (struct
> > > exynos_tmu_platform_data) members
> > >  		are used to configure the TMU.
> > > -b) TMU driver: This component initialises the TMU controller and
> > > sets different
> > > +b) TMU driver:
> > > +		This component initialises the TMU controller
> > > and
> > > sets different
> > >  		thresholds. It invokes core thermal
> > > implementation
> > > with the call
> > >  		exynos_report_trigger.
> > > -c) Exynos Core thermal wrapper: This provides 3 wrapper function
> > > to
> > > use the
> > > +c) Exynos Core thermal wrapper:
> > > +		This provides 3 wrapper function to use the
> > >  		Kernel core thermal framework. They are
> > > exynos_unregister_thermal,
> > >  		exynos_register_thermal and
> > > exynos_report_trigger.
> > > diff --git a/Documentation/thermal/exynos_thermal_emulation
> > > b/Documentation/thermal/exynos_thermal_emulation.rst
> > > similarity index 36%
> > > rename from Documentation/thermal/exynos_thermal_emulation
> > > rename to Documentation/thermal/exynos_thermal_emulation.rst
> > > index b15efec6ca28..c21d10838bc5 100644
> > > --- a/Documentation/thermal/exynos_thermal_emulation
> > > +++ b/Documentation/thermal/exynos_thermal_emulation.rst
> > > @@ -1,5 +1,6 @@
> > > -EXYNOS EMULATION MODE
> > > -========================
> > > +=====================
> > > +Exynos Emulation Mode
> > > +=====================
> > >  
> > >  Copyright (C) 2012 Samsung Electronics
> > >  
> > > @@ -8,46 +9,53 @@ Written by Jonghwa Lee <jonghwa3.lee@samsung.co
> > > m>
> > >  Description
> > >  -----------
> > >  
> > > -Exynos 4x12 (4212, 4412) and 5 series provide emulation mode for
> > > thermal management unit.
> > > -Thermal emulation mode supports software debug for TMU's
> > > operation.
> > > User can set temperature
> > > -manually with software code and TMU will read current
> > > temperature
> > > from user value not from
> > > -sensor's value.
> > > +Exynos 4x12 (4212, 4412) and 5 series provide emulation mode for
> > > thermal
> > > +management unit. Thermal emulation mode supports software debug
> > > for
> > > +TMU's operation. User can set temperature manually with software
> > > code
> > > +and TMU will read current temperature from user value not from
> > > sensor's
> > > +value.
> > >  
> > > -Enabling CONFIG_THERMAL_EMULATION option will make this support
> > > available.
> > > -When it's enabled, sysfs node will be created as
> > > +Enabling CONFIG_THERMAL_EMULATION option will make this support
> > > +available. When it's enabled, sysfs node will be created as
> > >  /sys/devices/virtual/thermal/thermal_zone'zone id'/emul_temp.
> > >  
> > > -The sysfs node, 'emul_node', will contain value 0 for the
> > > initial
> > > state. When you input any
> > > -temperature you want to update to sysfs node, it automatically
> > > enable emulation mode and
> > > -current temperature will be changed into it.
> > > -(Exynos also supports user changeable delay time which would be
> > > used
> > > to delay of
> > > - changing temperature. However, this node only uses same delay
> > > of
> > > real sensing time, 938us.)
> > > +The sysfs node, 'emul_node', will contain value 0 for the
> > > initial
> > > state.
> > > +When you input any temperature you want to update to sysfs node,
> > > it
> > > +automatically enable emulation mode and current temperature will
> > > be
> > > +changed into it.
> > >  
> > > -Exynos emulation mode requires synchronous of value changing and
> > > enabling. It means when you
> > > -want to update the any value of delay or next temperature, then
> > > you
> > > have to enable emulation
> > > -mode at the same time. (Or you have to keep the mode enabling.)
> > > If
> > > you don't, it fails to
> > > -change the value to updated one and just use last succeessful
> > > value
> > > repeatedly. That's why
> > > -this node gives users the right to change termerpature only.
> > > Just
> > > one interface makes it more
> > > -simply to use.
> > > +(Exynos also supports user changeable delay time which would be
> > > used
> > > to
> > > +delay of changing temperature. However, this node only uses same
> > > delay
> > > +of real sensing time, 938us.)
> > > +
> > > +Exynos emulation mode requires synchronous of value changing and
> > > +enabling. It means when you want to update the any value of
> > > delay or
> > > +next temperature, then you have to enable emulation mode at the
> > > same
> > > +time. (Or you have to keep the mode enabling.) If you don't, it
> > > fails to
> > > +change the value to updated one and just use last succeessful
> > > value
> > > +repeatedly. That's why this node gives users the right to change
> > > +termerpature only. Just one interface makes it more simply to
> > > use.
> > >  
> > >  Disabling emulation mode only requires writing value 0 to sysfs
> > > node.
> > >  
> > > +::
> > >  
> > > -TEMP	120 |
> > > +
> > > +  TEMP	120 |
> > >  	    |
> > >  	100 |
> > >  	    |
> > >  	 80 |
> > > -	    |		     	 	 +-----------
> > > -	 60 |      		     	 |	    |
> > > -	    |	           +-------------|          |
> > > +	    |				 +-----------
> > > +	 60 |      			 |	    |
> > > +	    |		   +-------------|          |
> > >  	 40 |              |         	 |          |
> > > -	    |		   |	     	 |        
> > >   |
> > > -	 20 |		   |	     	 |        
> > >   +-
> > > ---------
> > > -	    |	 	   |	     	 |       
> > >    |
> > >           |
> > > +	    |		   |		 |          |
> > > +	 20 |		   |		 |          +
> > > ----
> > > ------
> > > +	    |		   |		 |          |  
> > >     
> > >     |
> > >  	  0
> > > > 
> > > > ______________|_____________|__________|__________|_________
> > > -		   A	    	 A	    A	 
> > >   	
> > >        A     TIME
> > > +		   A		 A	    A		
> > >  
> > >       A     TIME
> > >  		   |<----->|	 |<----->|  |<----->|	
> > >    
> > >     |
> > >  		   | 938us |  	 |	 |  |       |   
> > >     
> > >    |
> > > -emulation    :  0  50	   |  	 70      |  20      |
> > >     
> > >       0
> > > -current temp :   sensor   50		 70         20	
> > >   
> > >     sensor
> > > +  emulation   : 0  50	   |  	 70      |  20      |
> > >     
> > >       0
> > > +  current temp:   sensor   50		 70         20	
> > >  
> > >      sensor
> > > diff --git a/Documentation/thermal/index.rst
> > > b/Documentation/thermal/index.rst
> > > new file mode 100644
> > > index 000000000000..8c1c00146cad
> > > --- /dev/null
> > > +++ b/Documentation/thermal/index.rst
> > > @@ -0,0 +1,18 @@
> > > +:orphan:
> > > +
> > > +=======
> > > +Thermal
> > > +=======
> > > +
> > > +.. toctree::
> > > +   :maxdepth: 1
> > > +
> > > +   cpu-cooling-api
> > > +   sysfs-api
> > > +   power_allocator
> > > +
> > > +   exynos_thermal
> > > +   exynos_thermal_emulation
> > > +   intel_powerclamp
> > > +   nouveau_thermal
> > > +   x86_pkg_temperature_thermal
> > > diff --git a/Documentation/thermal/intel_powerclamp.txt
> > > b/Documentation/thermal/intel_powerclamp.rst
> > > similarity index 76%
> > > rename from Documentation/thermal/intel_powerclamp.txt
> > > rename to Documentation/thermal/intel_powerclamp.rst
> > > index b5df21168fbc..3f6dfb0b3ea6 100644
> > > --- a/Documentation/thermal/intel_powerclamp.txt
> > > +++ b/Documentation/thermal/intel_powerclamp.rst
> > > @@ -1,10 +1,13 @@
> > > -			 =======================
> > > -			 INTEL POWERCLAMP DRIVER
> > > -			 =======================
> > > -By: Arjan van de Ven <arjan@linux.intel.com>
> > > -    Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > +=======================
> > > +Intel Powerclamp Driver
> > > +=======================
> > > +
> > > +By:
> > > +  - Arjan van de Ven <arjan@linux.intel.com>
> > > +  - Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > +
> > > +.. Contents:
> > >  
> > > -Contents:
> > >  	(*) Introduction
> > >  	    - Goals and Objectives
> > >  
> > > @@ -23,7 +26,6 @@ Contents:
> > >  	    - Generic Thermal Layer (sysfs)
> > >  	    - Kernel APIs (TBD)
> > >  
> > > -============
> > >  INTRODUCTION
> > >  ============
> > >  
> > > @@ -47,7 +49,6 @@ scalability, and user experience. In many
> > > cases,
> > > clear advantage is
> > >  shown over taking the CPU offline or modulating the CPU clock.
> > >  
> > >  
> > > -===================
> > >  THEORY OF OPERATION
> > >  ===================
> > >  
> > > @@ -57,11 +58,12 @@ Idle Injection
> > >  On modern Intel processors (Nehalem or later), package level C-
> > > state
> > >  residency is available in MSRs, thus also available to the
> > > kernel.
> > >  
> > > -These MSRs are:
> > > -      #define MSR_PKG_C2_RESIDENCY	0x60D
> > > -      #define MSR_PKG_C3_RESIDENCY	0x3F8
> > > -      #define MSR_PKG_C6_RESIDENCY	0x3F9
> > > -      #define MSR_PKG_C7_RESIDENCY	0x3FA
> > > +These MSRs are::
> > > +
> > > +      #define MSR_PKG_C2_RESIDENCY      0x60D
> > > +      #define MSR_PKG_C3_RESIDENCY      0x3F8
> > > +      #define MSR_PKG_C6_RESIDENCY      0x3F9
> > > +      #define MSR_PKG_C7_RESIDENCY      0x3FA
> > >  
> > >  If the kernel can also inject idle time to the system, then a
> > >  closed-loop control system can be established that manages
> > > package
> > > @@ -96,19 +98,21 @@ are not masked. Tests show that the extra
> > > wakeups
> > > from scheduler tick
> > >  have a dramatic impact on the effectiveness of the powerclamp
> > > driver
> > >  on large scale systems (Westmere system with 80 processors).
> > >  
> > > -CPU0
> > > -		  ____________          ____________
> > > -kidle_inject/0   |   sleep    |  mwait |  sleep     |
> > > -	_________|            |________|            |_______
> > > -			       duration
> > > -CPU1
> > > -		  ____________          ____________
> > > -kidle_inject/1   |   sleep    |  mwait |  sleep     |
> > > -	_________|            |________|            |_______
> > > -			      ^
> > > -			      |
> > > -			      |
> > > -			      roundup(jiffies, interval)
> > > +::
> > > +
> > > +  CPU0
> > > +		    ____________          ____________
> > > +  kidle_inject/0   |   sleep    |  mwait |  sleep     |
> > > +	  _________|            |________|            |_______
> > > +				 duration
> > > +  CPU1
> > > +		    ____________          ____________
> > > +  kidle_inject/1   |   sleep    |  mwait |  sleep     |
> > > +	  _________|            |________|            |_______
> > > +				^
> > > +				|
> > > +				|
> > > +				roundup(jiffies, interval)
> > >  
> > >  Only one CPU is allowed to collect statistics and update global
> > >  control parameters. This CPU is referred to as the controlling
> > > CPU
> > > in
> > > @@ -148,7 +152,7 @@ b) determine the amount of compensation
> > > needed at
> > > each target ratio
> > >  
> > >  Compensation to each target ratio consists of two parts:
> > >  
> > > -        a) steady state error compensation
> > > +	a) steady state error compensation
> > >  	This is to offset the error occurring when the system
> > > can
> > >  	enter idle without extra wakeups (such as external
> > > interrupts).
> > >  
> > > @@ -158,41 +162,42 @@ Compensation to each target ratio consists
> > > of
> > > two parts:
> > >  	slowing down CPU activities.
> > >  
> > >  A debugfs file is provided for the user to examine compensation
> > > -progress and results, such as on a Westmere system.
> > > -[jacob@nex01 ~]$ cat
> > > -/sys/kernel/debug/intel_powerclamp/powerclamp_calib
> > > -controlling cpu: 0
> > > -pct confidence steady dynamic (compensation)
> > > -0	0	0	0
> > > -1	1	0	0
> > > -2	1	1	0
> > > -3	3	1	0
> > > -4	3	1	0
> > > -5	3	1	0
> > > -6	3	1	0
> > > -7	3	1	0
> > > -8	3	1	0
> > > -...
> > > -30	3	2	0
> > > -31	3	2	0
> > > -32	3	1	0
> > > -33	3	2	0
> > > -34	3	1	0
> > > -35	3	2	0
> > > -36	3	1	0
> > > -37	3	2	0
> > > -38	3	1	0
> > > -39	3	2	0
> > > -40	3	3	0
> > > -41	3	1	0
> > > -42	3	2	0
> > > -43	3	1	0
> > > -44	3	1	0
> > > -45	3	2	0
> > > -46	3	3	0
> > > -47	3	0	0
> > > -48	3	2	0
> > > -49	3	3	0
> > > +progress and results, such as on a Westmere system::
> > > +
> > > +  [jacob@nex01 ~]$ cat
> > > +  /sys/kernel/debug/intel_powerclamp/powerclamp_calib
> > > +  controlling cpu: 0
> > > +  pct confidence steady dynamic (compensation)
> > > +  0       0       0       0
> > > +  1       1       0       0
> > > +  2       1       1       0
> > > +  3       3       1       0
> > > +  4       3       1       0
> > > +  5       3       1       0
> > > +  6       3       1       0
> > > +  7       3       1       0
> > > +  8       3       1       0
> > > +  ...
> > > +  30      3       2       0
> > > +  31      3       2       0
> > > +  32      3       1       0
> > > +  33      3       2       0
> > > +  34      3       1       0
> > > +  35      3       2       0
> > > +  36      3       1       0
> > > +  37      3       2       0
> > > +  38      3       1       0
> > > +  39      3       2       0
> > > +  40      3       3       0
> > > +  41      3       1       0
> > > +  42      3       2       0
> > > +  43      3       1       0
> > > +  44      3       1       0
> > > +  45      3       2       0
> > > +  46      3       3       0
> > > +  47      3       0       0
> > > +  48      3       2       0
> > > +  49      3       3       0
> > >  
> > >  Calibration occurs during runtime. No offline method is
> > > available.
> > >  Steady state compensation is used only when confidence levels of
> > > all
> > > @@ -217,9 +222,8 @@ keeps track of clamping kernel threads, even
> > > after they are migrated
> > >  to other CPUs, after a CPU offline event.
> > >  
> > >  
> > > -=====================
> > >  Performance Analysis
> > > -=====================
> > > +====================
> > >  This section describes the general performance data collected on
> > >  multiple systems, including Westmere (80P) and Ivy Bridge (4P,
> > > 8P).
> > >  
> > > @@ -257,16 +261,15 @@ achieve up to 40% better performance per
> > > watt.
> > > (measured by a spin
> > >  counter summed over per CPU counting threads spawned for all
> > > running
> > >  CPUs).
> > >  
> > > -====================
> > >  Usage and Interfaces
> > >  ====================
> > >  The powerclamp driver is registered to the generic thermal layer
> > > as
> > > a
> > > -cooling device. Currently, it’s not bound to any thermal zones.
> > > +cooling device. Currently, it’s not bound to any thermal zones::
> > >  
> > > -jacob@chromoly:/sys/class/thermal/cooling_device14$ grep . *
> > > -cur_state:0
> > > -max_state:50
> > > -type:intel_powerclamp
> > > +  jacob@chromoly:/sys/class/thermal/cooling_device14$ grep . *
> > > +  cur_state:0
> > > +  max_state:50
> > > +  type:intel_powerclamp
> > >  
> > >  cur_state allows user to set the desired idle percentage.
> > > Writing 0
> > > to
> > >  cur_state will stop idle injection. Writing a value between 1
> > > and
> > > @@ -278,9 +281,9 @@ cur_state returns value -1 instead of 0 which
> > > is
> > > to avoid confusing
> > >  100% busy state with the disabled state.
> > >  
> > >  Example usage:
> > > -- To inject 25% idle time
> > > -$ sudo sh -c "echo 25 >
> > > /sys/class/thermal/cooling_device80/cur_state
> > > -"
> > > +- To inject 25% idle time::
> > > +
> > > +	$ sudo sh -c "echo 25 >
> > > /sys/class/thermal/cooling_device80/cur_state
> > >  
> > >  If the system is not busy and has more than 25% idle time
> > > already,
> > >  then the powerclamp driver will not start idle injection. Using
> > > Top
> > > @@ -292,23 +295,23 @@ idle time is accounted as normal idle in
> > > that
> > > common code path is
> > >  taken as the idle task.
> > >  
> > >  In this example, 24.1% idle is shown. This helps the system
> > > admin or
> > > -user determine the cause of slowdown, when a powerclamp driver
> > > is in
> > > action.
> > > +user determine the cause of slowdown, when a powerclamp driver
> > > is in
> > > action::
> > >  
> > >  
> > > -Tasks: 197 total,   1 running, 196 sleeping,   0 stopped,   0
> > > zombie
> > > -Cpu(s): 71.2%us,  4.7%sy,  0.0%ni,
> > > 24.1%id,  0.0%wa,  0.0%hi,  0.0%si,  0.0%st
> > > -Mem:   3943228k total,  1689632k used,  2253596k free,    74960k
> > > buffers
> > > -Swap:  4087804k total,        0k used,  4087804k free,   945336k
> > > cached
> > > +  Tasks: 197 total,   1 running, 196 sleeping,   0 stopped,   0
> > > zombie
> > > +  Cpu(s): 71.2%us,  4.7%sy,  0.0%ni,
> > > 24.1%id,  0.0%wa,  0.0%hi,  0.0%si,  0.0%st
> > > +  Mem:   3943228k total,  1689632k used,  2253596k
> > > free,    74960k
> > > buffers
> > > +  Swap:  4087804k total,        0k used,  4087804k
> > > free,   945336k
> > > cached
> > >  
> > > -  PID USER      PR  NI  VIRT  RES  SHR S %CPU
> > > %MEM    TIME+  COMMAND
> > > - 3352 jacob     20   0  262m  644  428 S  286  0.0   0:17.16
> > > spin
> > > - 3341 root     -51   0     0    0    0 D   25  0.0   0:01.62
> > > kidle_inject/0
> > > - 3344 root     -51   0     0    0    0 D   25  0.0   0:01.60
> > > kidle_inject/3
> > > - 3342 root     -51   0     0    0    0 D   25  0.0   0:01.61
> > > kidle_inject/1
> > > - 3343 root     -51   0     0    0    0 D   25  0.0   0:01.60
> > > kidle_inject/2
> > > - 2935 jacob     20   0  696m 125m  35m S    5  3.3   0:31.11
> > > firefox
> > > - 1546 root      20   0  158m  20m 6640 S    3  0.5   0:26.97
> > > Xorg
> > > - 2100 jacob     20   0 1223m  88m  30m S    3  2.3   0:23.68
> > > compiz
> > > +    PID USER      PR  NI  VIRT  RES  SHR S %CPU
> > > %MEM    TIME+  COMMAND
> > > +   3352 jacob     20   0  262m  644  428 S  286  0.0   0:17.16
> > > spin
> > > +   3341 root     -51   0     0    0    0 D   25  0.0   0:01.62
> > > kidle_inject/0
> > > +   3344 root     -51   0     0    0    0 D   25  0.0   0:01.60
> > > kidle_inject/3
> > > +   3342 root     -51   0     0    0    0 D   25  0.0   0:01.61
> > > kidle_inject/1
> > > +   3343 root     -51   0     0    0    0 D   25  0.0   0:01.60
> > > kidle_inject/2
> > > +   2935 jacob     20   0  696m 125m  35m S    5  3.3   0:31.11
> > > firefox
> > > +   1546 root      20   0  158m  20m 6640 S    3  0.5   0:26.97
> > > Xorg
> > > +   2100 jacob     20   0 1223m  88m  30m S    3  2.3   0:23.68
> > > compiz
> > >  
> > >  Tests have shown that by using the powerclamp driver as a
> > > cooling
> > >  device, a PID based userspace thermal controller can manage to
> > > diff --git a/Documentation/thermal/nouveau_thermal
> > > b/Documentation/thermal/nouveau_thermal.rst
> > > similarity index 64%
> > > rename from Documentation/thermal/nouveau_thermal
> > > rename to Documentation/thermal/nouveau_thermal.rst
> > > index 6e17a11efcb0..37255fd6735d 100644
> > > --- a/Documentation/thermal/nouveau_thermal
> > > +++ b/Documentation/thermal/nouveau_thermal.rst
> > > @@ -1,13 +1,15 @@
> > > +=====================
> > >  Kernel driver nouveau
> > > -===================
> > > +=====================
> > >  
> > >  Supported chips:
> > > +
> > >  * NV43+
> > >  
> > >  Authors: Martin Peres (mupuf) <martin.peres@free.fr>
> > >  
> > >  Description
> > > ----------
> > > +-----------
> > >  
> > >  This driver allows to read the GPU core temperature, drive the
> > > GPU
> > > fan and
> > >  set temperature alarms.
> > > @@ -19,20 +21,25 @@ interface is likely not to work. This
> > > document
> > > may then not cover your situation
> > >  entirely.
> > >  
> > >  Temperature management
> > > ---------------------
> > > +----------------------
> > >  
> > >  Temperature is exposed under as a read-only HWMON attribute
> > > temp1_input.
> > >  
> > >  In order to protect the GPU from overheating, Nouveau supports 4
> > > configurable
> > >  temperature thresholds:
> > >  
> > > - * Fan_boost: Fan speed is set to 100% when reaching this
> > > temperature;
> > > - * Downclock: The GPU will be downclocked to reduce its power
> > > dissipation;
> > > - * Critical: The GPU is put on hold to further lower power
> > > dissipation;
> > > - * Shutdown: Shut the computer down to protect your GPU.
> > > + * Fan_boost:
> > > +	Fan speed is set to 100% when reaching this temperature;
> > > + * Downclock:
> > > +	The GPU will be downclocked to reduce its power
> > > dissipation;
> > > + * Critical:
> > > +	The GPU is put on hold to further lower power
> > > dissipation;
> > > + * Shutdown:
> > > +	Shut the computer down to protect your GPU.
> > >  
> > > -WARNING: Some of these thresholds may not be used by Nouveau
> > > depending
> > > -on your chipset.
> > > +WARNING:
> > > +	Some of these thresholds may not be used by Nouveau
> > > depending
> > > +	on your chipset.
> > >  
> > >  The default value for these thresholds comes from the GPU's
> > > vbios.
> > > These
> > >  thresholds can be configured thanks to the following HWMON
> > > attributes:
> > > @@ -46,19 +53,24 @@ NOTE: Remember that the values are stored as
> > > milli degrees Celsius. Don't forget
> > >  to multiply!
> > >  
> > >  Fan management
> > > -------------
> > > +--------------
> > >  
> > >  Not all cards have a drivable fan. If you do, then the following
> > > HWMON
> > >  attributes should be available:
> > >  
> > > - * pwm1_enable: Current fan management mode (NONE, MANUAL or
> > > AUTO);
> > > - * pwm1: Current PWM value (power percentage);
> > > - * pwm1_min: The minimum PWM speed allowed;
> > > - * pwm1_max: The maximum PWM speed allowed (bypassed when
> > > hitting
> > > Fan_boost);
> > > + * pwm1_enable:
> > > +	Current fan management mode (NONE, MANUAL or AUTO);
> > > + * pwm1:
> > > +	Current PWM value (power percentage);
> > > + * pwm1_min:
> > > +	The minimum PWM speed allowed;
> > > + * pwm1_max:
> > > +	The maximum PWM speed allowed (bypassed when hitting
> > > Fan_boost);
> > >  
> > >  You may also have the following attribute:
> > >  
> > > - * fan1_input: Speed in RPM of your fan.
> > > + * fan1_input:
> > > +	Speed in RPM of your fan.
> > >  
> > >  Your fan can be driven in different modes:
> > >  
> > > @@ -66,14 +78,16 @@ Your fan can be driven in different modes:
> > >   * 1: The fan can be driven in manual (use pwm1 to change the
> > > speed);
> > >   * 2; The fan is driven automatically depending on the
> > > temperature.
> > >  
> > > -NOTE: Be sure to use the manual mode if you want to drive the
> > > fan
> > > speed manually
> > > +NOTE:
> > > +  Be sure to use the manual mode if you want to drive the fan
> > > speed
> > > manually
> > >  
> > > -NOTE2: When operating in manual mode outside the vbios-defined
> > > -[PWM_min, PWM_max] range, the reported fan speed (RPM) may not
> > > be
> > > accurate
> > > -depending on your hardware.
> > > +NOTE2:
> > > +  When operating in manual mode outside the vbios-defined
> > > +  [PWM_min, PWM_max] range, the reported fan speed (RPM) may not
> > > be
> > > accurate
> > > +  depending on your hardware.
> > >  
> > >  Bug reports
> > > ----------
> > > +-----------
> > >  
> > >  Thermal management on Nouveau is new and may not work on all
> > > cards.
> > > If you have
> > >  inquiries, please ping mupuf on IRC (#nouveau, freenode).
> > > diff --git a/Documentation/thermal/power_allocator.txt
> > > b/Documentation/thermal/power_allocator.rst
> > > similarity index 74%
> > > rename from Documentation/thermal/power_allocator.txt
> > > rename to Documentation/thermal/power_allocator.rst
> > > index 9fb0ff06dca9..67b6a3297238 100644
> > > --- a/Documentation/thermal/power_allocator.txt
> > > +++ b/Documentation/thermal/power_allocator.rst
> > > @@ -1,3 +1,4 @@
> > > +=================================
> > >  Power allocator governor tunables
> > >  =================================
> > >  
> > > @@ -25,36 +26,36 @@ temperature as the control input and power as
> > > the
> > > controlled output:
> > >      P_max = k_p * e + k_i * err_integral + k_d * diff_err +
> > > sustainable_power
> > >  
> > >  where
> > > -    e = desired_temperature - current_temperature
> > > -    err_integral is the sum of previous errors
> > > -    diff_err = e - previous_error
> > > +   -  e = desired_temperature - current_temperature
> > > +   -  err_integral is the sum of previous errors
> > > +   -  diff_err = e - previous_error
> > >  
> > > -It is similar to the one depicted below:
> > > +It is similar to the one depicted below::
> > >  
> > > -                                      k_d
> > > -                                       |
> > > -current_temp                           |
> > > -     |                                 v
> > > -     |                +----------+   +---+
> > > -     |         +----->| diff_err |-->| X |------+
> > > -     |         |      +----------+   +---+      |
> > > -     |         |                                |      tdp      
> > >   ac
> > > tor
> > > -     |         |                      k_i       |       |  get_r
> > > eque
> > > sted_power()
> > > -     |         |                       |        |       |       
> > >  |  
> > >    |
> > > -     |         |                       |        |       |       
> > >  |  
> > >    | ...
> > > -     v         |                       v        v       v       
> > >  v  
> > >    v
> > > -   +---+       |      +-------+      +---+    +---+   +---+   +-
> > > ----
> > > -----+
> > > -   | S |-------+----->| sum e |----->| X |--->| S |-->| S |  
> > > -->|power     |  
> > > -   +---+       |      +-------+      +---+    +---+   +---
> > > +   |allocation|
> > > -     ^         |                                ^             +-
> > > ----
> > > -----+
> > > -     |         |                                |               
> > >  |  
> > >    |
> > > -     |         |        +---
> > > +                   |                |     |
> > > -     |         +------->| X |-------------------
> > > +                v     v
> > > -     |                  +---
> > > +                               granted
> > > performance
> > > -desired_temperature       ^
> > > -                          |
> > > -                          |
> > > -                      k_po/k_pu
> > > +				      k_d
> > > +				       |
> > > +  current_temp                         |
> > > +       |                               v
> > > +       |              +----------+   +---+
> > > +       |       +----->| diff_err |-->| X |------+
> > > +       |       |      +----------+   +---+      |
> > > +       |       |                                |      tdp      
> > >   ac
> > > tor
> > > +       |       |                      k_i       |       |  get_r
> > > eque
> > > sted_power()
> > > +       |       |                       |        |       |       
> > >  |  
> > >    |
> > > +       |       |                       |        |       |       
> > >  |  
> > >    | ...
> > > +       v       |                       v        v       v       
> > >  v  
> > >    v
> > > +     +---+     |      +-------+      +---+    +---+   +---+   +-
> > > ----
> > > -----+
> > > +     | S |-----+----->| sum e |----->| X |--->| S |-->| S |  
> > > -->|power     |  
> > > +     +---+     |      +-------+      +---+    +---+   +---
> > > +   |allocation|
> > > +       ^       |                                ^             +-
> > > ----
> > > -----+
> > > +       |       |                                |               
> > >  |  
> > >    |
> > > +       |       |        +---
> > > +                   |                |     |
> > > +       |       +------->| X |-------------------
> > > +                v     v
> > > +       |                +---
> > > +                               granted
> > > performance
> > > +  desired_temperature     ^
> > > +			  |
> > > +			  |
> > > +		      k_po/k_pu
> > >  
> > >  Sustainable power
> > >  -----------------
> > > @@ -73,7 +74,7 @@ is typically 2000mW, while on a 10" tablet is
> > > around 4500mW (may vary
> > >  depending on screen size).
> > >  
> > >  If you are using device tree, do add it as a property of the
> > > -thermal-zone.  For example:
> > > +thermal-zone.  For example::
> > >  
> > >  	thermal-zones {
> > >  		soc_thermal {
> > > @@ -85,7 +86,7 @@ thermal-zone.  For example:
> > >  Instead, if the thermal zone is registered from the platform
> > > code,
> > > pass a
> > >  `thermal_zone_params` that has a `sustainable_power`.  If no
> > >  `thermal_zone_params` were being passed, then something like
> > > below
> > > -will suffice:
> > > +will suffice::
> > >  
> > >  	static const struct thermal_zone_params tz_params = {
> > >  		.sustainable_power = 3500,
> > > @@ -112,18 +113,18 @@ available capacity at a low
> > > temperature.  On
> > > the other hand, a high
> > >  value of `k_pu` will result in the governor granting very high
> > > power
> > >  while temperature is low, and may lead to temperature
> > > overshooting.
> > >  
> > > -The default value for `k_pu` is:
> > > +The default value for `k_pu` is::
> > >  
> > >      2 * sustainable_power / (desired_temperature -
> > > switch_on_temp)
> > >  
> > >  This means that at `switch_on_temp` the output of the
> > > controller's
> > >  proportional term will be 2 * `sustainable_power`.  The default
> > > value
> > > -for `k_po` is:
> > > +for `k_po` is::
> > >  
> > >      sustainable_power / (desired_temperature - switch_on_temp)
> > >  
> > >  Focusing on the proportional and feed forward values of the PID
> > > -controller equation we have:
> > > +controller equation we have::
> > >  
> > >      P_max = k_p * e + sustainable_power
> > >  
> > > @@ -134,21 +135,23 @@ is the desired one, then the proportional
> > > component is zero and
> > >  thermal equilibrium under constant load.  `sustainable_power` is
> > > only
> > >  an estimate, which is the reason for closed-loop control such as
> > > this.
> > >  
> > > -Expanding `k_pu` we get:
> > > +Expanding `k_pu` we get::
> > > +
> > >      P_max = 2 * sustainable_power * (T_set - T) / (T_set - T_on)
> > > +
> > > -        sustainable_power
> > > +	sustainable_power
> > >  
> > > -where
> > > -    T_set is the desired temperature
> > > -    T is the current temperature
> > > -    T_on is the switch on temperature
> > > +where:
> > > +
> > > +    - T_set is the desired temperature
> > > +    - T is the current temperature
> > > +    - T_on is the switch on temperature
> > >  
> > >  When the current temperature is the switch_on temperature, the
> > > above
> > > -formula becomes:
> > > +formula becomes::
> > >  
> > >      P_max = 2 * sustainable_power * (T_set - T_on) / (T_set -
> > > T_on)
> > > +
> > > -        sustainable_power = 2 * sustainable_power +
> > > sustainable_power =
> > > -        3 * sustainable_power
> > > +	sustainable_power = 2 * sustainable_power +
> > > sustainable_power =
> > > +	3 * sustainable_power
> > >  
> > >  Therefore, the proportional term alone linearly decreases power
> > > from
> > >  3 * `sustainable_power` to `sustainable_power` as the
> > > temperature
> > > @@ -178,11 +181,18 @@ Cooling device power API
> > >  Cooling devices controlled by this governor must supply the
> > > additional
> > >  "power" API in their `cooling_device_ops`.  It consists on three
> > > ops:
> > >  
> > > -1. int get_requested_power(struct thermal_cooling_device *cdev,
> > > -	struct thermal_zone_device *tz, u32 *power);
> > > -@cdev: The `struct thermal_cooling_device` pointer
> > > -@tz: thermal zone in which we are currently operating
> > > -@power: pointer in which to store the calculated power
> > > +1. ::
> > > +
> > > +    int get_requested_power(struct thermal_cooling_device *cdev,
> > > +			    struct thermal_zone_device *tz, u32
> > > *power);
> > > +
> > > +
> > > +@cdev:
> > > +	The `struct thermal_cooling_device` pointer
> > > +@tz:
> > > +	thermal zone in which we are currently operating
> > > +@power:
> > > +	pointer in which to store the calculated power
> > >  
> > >  `get_requested_power()` calculates the power requested by the
> > > device
> > >  in milliwatts and stores it in @power .  It should return 0 on
> > > @@ -190,23 +200,37 @@ success, -E* on failure.  This is currently
> > > used by the power
> > >  allocator governor to calculate how much power to give to each
> > > cooling
> > >  device.
> > >  
> > > -2. int state2power(struct thermal_cooling_device *cdev, struct
> > > -        thermal_zone_device *tz, unsigned long state, u32
> > > *power);
> > > -@cdev: The `struct thermal_cooling_device` pointer
> > > -@tz: thermal zone in which we are currently operating
> > > -@state: A cooling device state
> > > -@power: pointer in which to store the equivalent power
> > > +2. ::
> > > +
> > > +	int state2power(struct thermal_cooling_device *cdev,
> > > struct
> > > +			thermal_zone_device *tz, unsigned long
> > > state,
> > > +			u32 *power);
> > > +
> > > +@cdev:
> > > +	The `struct thermal_cooling_device` pointer
> > > +@tz:
> > > +	thermal zone in which we are currently operating
> > > +@state:
> > > +	A cooling device state
> > > +@power:
> > > +	pointer in which to store the equivalent power
> > >  
> > >  Convert cooling device state @state into power consumption in
> > >  milliwatts and store it in @power.  It should return 0 on
> > > success,
> > > -E*
> > >  on failure.  This is currently used by thermal core to calculate
> > > the
> > >  maximum power that an actor can consume.
> > >  
> > > -3. int power2state(struct thermal_cooling_device *cdev, u32
> > > power,
> > > -	unsigned long *state);
> > > -@cdev: The `struct thermal_cooling_device` pointer
> > > -@power: power in milliwatts
> > > -@state: pointer in which to store the resulting state
> > > +3. ::
> > > +
> > > +	int power2state(struct thermal_cooling_device *cdev, u32
> > > power,
> > > +			unsigned long *state);
> > > +
> > > +@cdev:
> > > +	The `struct thermal_cooling_device` pointer
> > > +@power:
> > > +	power in milliwatts
> > > +@state:
> > > +	pointer in which to store the resulting state
> > >  
> > >  Calculate a cooling device state that would make the device
> > > consume
> > > at
> > >  most @power mW and store it in @state.  It should return 0 on
> > > success,
> > > diff --git a/Documentation/thermal/sysfs-api.txt
> > > b/Documentation/thermal/sysfs-api.rst
> > > similarity index 66%
> > > rename from Documentation/thermal/sysfs-api.txt
> > > rename to Documentation/thermal/sysfs-api.rst
> > > index c3fa500df92c..e4930761d3e5 100644
> > > --- a/Documentation/thermal/sysfs-api.txt
> > > +++ b/Documentation/thermal/sysfs-api.rst
> > > @@ -1,3 +1,4 @@
> > > +===================================
> > >  Generic Thermal Sysfs driver How To
> > >  ===================================
> > >  
> > > @@ -9,6 +10,7 @@ Copyright (c)  2008 Intel Corporation
> > >  
> > >  
> > >  0. Introduction
> > > +===============
> > >  
> > >  The generic thermal sysfs provides a set of interfaces for
> > > thermal
> > > zone
> > >  devices (sensors) and thermal cooling devices (fan,
> > > processor...) to
> > > register
> > > @@ -25,59 +27,90 @@ An intelligent thermal management application
> > > can
> > > make decisions based on
> > >  inputs from thermal zone attributes (the current temperature and
> > > trip point
> > >  temperature) and throttle appropriate devices.
> > >  
> > > -[0-*]	denotes any positive number starting from 0
> > > -[1-*]	denotes any positive number starting from 1
> > > +- `[0-*]`	denotes any positive number starting from 0
> > > +- `[1-*]`	denotes any positive number starting from 1
> > >  
> > >  1. thermal sysfs driver interface functions
> > > +===========================================
> > >  
> > >  1.1 thermal zone device interface
> > > -1.1.1 struct thermal_zone_device
> > > *thermal_zone_device_register(char
> > > *type,
> > > -		int trips, int mask, void *devdata,
> > > -		struct thermal_zone_device_ops *ops,
> > > -		const struct thermal_zone_params *tzp,
> > > -		int passive_delay, int polling_delay))
> > > +---------------------------------
> > > +
> > > +    ::
> > > +
> > > +	struct thermal_zone_device
> > > +	*thermal_zone_device_register(char *type,
> > > +				      int trips, int mask, void
> > > *devdata,
> > > +				      struct
> > > thermal_zone_device_ops
> > > *ops,
> > > +				      const struct
> > > thermal_zone_params *tzp,
> > > +				      int passive_delay, int
> > > polling_delay))
> > >  
> > >      This interface function adds a new thermal zone device
> > > (sensor)
> > > to
> > > -    /sys/class/thermal folder as thermal_zone[0-*]. It tries to
> > > bind
> > > all the
> > > +    /sys/class/thermal folder as `thermal_zone[0-*]`. It tries
> > > to
> > > bind all the
> > >      thermal cooling devices registered at the same time.
> > >  
> > > -    type: the thermal zone type.
> > > -    trips: the total number of trip points this thermal zone
> > > supports.
> > > -    mask: Bit string: If 'n'th bit is set, then trip point 'n'
> > > is
> > > writeable.
> > > -    devdata: device private data
> > > -    ops: thermal zone device call-backs.
> > > -	.bind: bind the thermal zone device with a thermal
> > > cooling
> > > device.
> > > -	.unbind: unbind the thermal zone device with a thermal
> > > cooling device.
> > > -	.get_temp: get the current temperature of the thermal
> > > zone.
> > > -	.set_trips: set the trip points window. Whenever the
> > > current
> > > temperature
> > > +    type:
> > > +	the thermal zone type.
> > > +    trips:
> > > +	the total number of trip points this thermal zone
> > > supports.
> > > +    mask:
> > > +	Bit string: If 'n'th bit is set, then trip point 'n' is
> > > writeable.
> > > +    devdata:
> > > +	device private data
> > > +    ops:
> > > +	thermal zone device call-backs.
> > > +
> > > +	.bind:
> > > +		bind the thermal zone device with a thermal
> > > cooling
> > > device.
> > > +	.unbind:
> > > +		unbind the thermal zone device with a thermal
> > > cooling device.
> > > +	.get_temp:
> > > +		get the current temperature of the thermal zone.
> > > +	.set_trips:
> > > +		    set the trip points window. Whenever the
> > > current
> > > temperature
> > >  		    is updated, the trip points immediately
> > > below
> > > and above the
> > >  		    current temperature are found.
> > > -	.get_mode: get the current mode (enabled/disabled) of
> > > the
> > > thermal zone.
> > > -	    - "enabled" means the kernel thermal management is
> > > enabled.
> > > -	    - "disabled" will prevent kernel thermal driver
> > > action
> > > upon trip points
> > > -	      so that user applications can take charge of
> > > thermal
> > > management.
> > > -	.set_mode: set the mode (enabled/disabled) of the
> > > thermal
> > > zone.
> > > -	.get_trip_type: get the type of certain trip point.
> > > -	.get_trip_temp: get the temperature above which the
> > > certain
> > > trip point
> > > +	.get_mode:
> > > +		   get the current mode (enabled/disabled) of
> > > the
> > > thermal zone.
> > > +
> > > +			- "enabled" means the kernel thermal
> > > management is
> > > +			  enabled.
> > > +			- "disabled" will prevent kernel thermal
> > > driver action
> > > +			  upon trip points so that user
> > > applications
> > > can take
> > > +			  charge of thermal management.
> > > +	.set_mode:
> > > +		set the mode (enabled/disabled) of the thermal
> > > zone.
> > > +	.get_trip_type:
> > > +		get the type of certain trip point.
> > > +	.get_trip_temp:
> > > +			get the temperature above which the
> > > certain
> > > trip point
> > >  			will be fired.
> > > -	.set_emul_temp: set the emulation temperature which
> > > helps in
> > > debugging
> > > +	.set_emul_temp:
> > > +			set the emulation temperature which
> > > helps in
> > > debugging
> > >  			different threshold temperature points.
> > > -    tzp: thermal zone platform parameters.
> > > -    passive_delay: number of milliseconds to wait between polls
> > > when
> > > +    tzp:
> > > +	thermal zone platform parameters.
> > > +    passive_delay:
> > > +	number of milliseconds to wait between polls when
> > >  	performing passive cooling.
> > > -    polling_delay: number of milliseconds to wait between polls
> > > when
> > > checking
> > > +    polling_delay:
> > > +	number of milliseconds to wait between polls when
> > > checking
> > >  	whether trip points have been crossed (0 for interrupt
> > > driven systems).
> > >  
> > > +    ::
> > >  
> > > -1.1.2 void thermal_zone_device_unregister(struct
> > > thermal_zone_device
> > > *tz)
> > > +	void thermal_zone_device_unregister(struct
> > > thermal_zone_device *tz)
> > >  
> > >      This interface function removes the thermal zone device.
> > >      It deletes the corresponding entry from /sys/class/thermal
> > > folder and
> > >      unbinds all the thermal cooling devices it uses.
> > >  
> > > -1.1.3 struct thermal_zone_device
> > > *thermal_zone_of_sensor_register(
> > > -		struct device *dev, int sensor_id, void *data,
> > > -		const struct thermal_zone_of_device_ops *ops)
> > > +	::
> > > +
> > > +	   struct thermal_zone_device
> > > +	   *thermal_zone_of_sensor_register(struct device *dev,
> > > int
> > > sensor_id,
> > > +				void *data,
> > > +				const struct
> > > thermal_zone_of_device_ops *ops)
> > >  
> > >  	This interface adds a new sensor to a DT thermal zone.
> > >  	This function will search the list of thermal zones
> > > described in
> > > @@ -87,25 +120,33 @@ temperature) and throttle appropriate
> > > devices.
> > >  	thermal zone device.
> > >  
> > >  	The parameters for this interface are:
> > > -	dev:		Device node of sensor containing
> > > valid
> > > node pointer in
> > > +
> > > +	dev:
> > > +			Device node of sensor containing valid
> > > node
> > > pointer in
> > >  			dev->of_node.
> > > -	sensor_id:	a sensor identifier, in case the
> > > sensor IP
> > > has more
> > > +	sensor_id:
> > > +			a sensor identifier, in case the sensor
> > > IP
> > > has more
> > >  			than one sensors
> > > -	data:		a private pointer (owned by the
> > > caller)
> > > that will be
> > > +	data:
> > > +			a private pointer (owned by the caller)
> > > that
> > > will be
> > >  			passed back, when a temperature reading
> > > is
> > > needed.
> > > -	ops:		struct thermal_zone_of_device_ops *.
> > > +	ops:
> > > +			`struct thermal_zone_of_device_ops *`.
> > >  
> > > -			get_temp:	a pointer to a function
> > > that reads the
> > > +			==============  ========================
> > > ====
> > > ===========
> > > +			get_temp	a pointer to a function
> > > that
> > > reads the
> > >  					sensor temperature. This
> > > is
> > > mandatory
> > >  					callback provided by
> > > sensor
> > > driver.
> > > -			set_trips:      a pointer to a function
> > > that
> > > sets a
> > > +			set_trips	a pointer to a function
> > > that sets a
> > >  					temperature window. When
> > > this window is
> > >  					left the driver must
> > > inform
> > > the thermal
> > >  					core via
> > > thermal_zone_device_update.
> > > -			get_trend: 	a pointer to a
> > > function
> > > that reads the
> > > +			get_trend 	a pointer to a
> > > function
> > > that reads the
> > >  					sensor temperature
> > > trend.
> > > -			set_emul_temp:	a pointer to a
> > > function that sets
> > > +			set_emul_temp	a pointer to a
> > > function
> > > that sets
> > >  					sensor emulated
> > > temperature.
> > > +			==============  ========================
> > > ====
> > > ===========
> > > +
> > >  	The thermal zone temperature is provided by the
> > > get_temp()
> > > function
> > >  	pointer of thermal_zone_of_device_ops. When called, it
> > > will
> > >  	have the private pointer @data back.
> > > @@ -114,8 +155,10 @@ temperature) and throttle appropriate
> > > devices.
> > >  	handle. Caller should check the return handle with
> > > IS_ERR()
> > > for finding
> > >  	whether success or not.
> > >  
> > > -1.1.4 void thermal_zone_of_sensor_unregister(struct device *dev,
> > > -		struct thermal_zone_device *tzd)
> > > +	::
> > > +
> > > +	    void thermal_zone_of_sensor_unregister(struct device
> > > *dev,
> > > +						   struct
> > > thermal_zone_device *tzd)
> > >  
> > >  	This interface unregisters a sensor from a DT thermal
> > > zone
> > > which was
> > >  	successfully added by interface
> > > thermal_zone_of_sensor_register().
> > > @@ -124,21 +167,29 @@ temperature) and throttle appropriate
> > > devices.
> > >  	interface. It will also silent the zone by remove the
> > > .get_temp() and
> > >  	get_trend() thermal zone device callbacks.
> > >  
> > > -1.1.5 struct thermal_zone_device
> > > *devm_thermal_zone_of_sensor_register(
> > > -		struct device *dev, int sensor_id,
> > > -		void *data, const struct
> > > thermal_zone_of_device_ops
> > > *ops)
> > > +	::
> > > +
> > > +	  struct thermal_zone_device
> > > +	  *devm_thermal_zone_of_sensor_register(struct device
> > > *dev,
> > > +				int sensor_id,
> > > +				void *data,
> > > +				const struct
> > > thermal_zone_of_device_ops *ops)
> > >  
> > >  	This interface is resource managed version of
> > >  	thermal_zone_of_sensor_register().
> > > +
> > >  	All details of thermal_zone_of_sensor_register()
> > > described
> > > in
> > >  	section 1.1.3 is applicable here.
> > > +
> > >  	The benefit of using this interface to register sensor
> > > is
> > > that it
> > >  	is not require to explicitly call
> > > thermal_zone_of_sensor_unregister()
> > >  	in error path or during driver unbinding as this is done
> > > by
> > > driver
> > >  	resource manager.
> > >  
> > > -1.1.6 void devm_thermal_zone_of_sensor_unregister(struct device
> > > *dev,
> > > -		struct thermal_zone_device *tzd)
> > > +	::
> > > +
> > > +		void
> > > devm_thermal_zone_of_sensor_unregister(struct
> > > device *dev,
> > > +						struct
> > > thermal_zone_device *tzd)
> > >  
> > >  	This interface is resource managed version of
> > >  	thermal_zone_of_sensor_unregister().
> > > @@ -147,123 +198,186 @@ temperature) and throttle appropriate
> > > devices.
> > >  	Normally this function will not need to be called and
> > > the
> > > resource
> > >  	management code will ensure that the resource is freed.
> > >  
> > > -1.1.7 int thermal_zone_get_slope(struct thermal_zone_device *tz)
> > > +	::
> > > +
> > > +		int thermal_zone_get_slope(struct
> > > thermal_zone_device *tz)
> > >  
> > >  	This interface is used to read the slope attribute value
> > >  	for the thermal zone device, which might be useful for
> > > platform
> > >  	drivers for temperature calculations.
> > >  
> > > -1.1.8 int thermal_zone_get_offset(struct thermal_zone_device
> > > *tz)
> > > +	::
> > > +
> > > +		int thermal_zone_get_offset(struct
> > > thermal_zone_device *tz)
> > >  
> > >  	This interface is used to read the offset attribute
> > > value
> > >  	for the thermal zone device, which might be useful for
> > > platform
> > >  	drivers for temperature calculations.
> > >  
> > >  1.2 thermal cooling device interface
> > > -1.2.1 struct thermal_cooling_device
> > > *thermal_cooling_device_register(char *name,
> > > -		void *devdata, struct thermal_cooling_device_ops
> > > *)
> > > +------------------------------------
> > > +
> > > +
> > > +    ::
> > > +
> > > +	struct thermal_cooling_device
> > > +	*thermal_cooling_device_register(char *name,
> > > +			void *devdata, struct
> > > thermal_cooling_device_ops *)
> > >  
> > >      This interface function adds a new thermal cooling device
> > > (fan/processor/...)
> > > -    to /sys/class/thermal/ folder as cooling_device[0-*]. It
> > > tries
> > > to bind itself
> > > +    to /sys/class/thermal/ folder as `cooling_device[0-*]`. It
> > > tries
> > > to bind itself
> > >      to all the thermal zone devices registered at the same time.
> > > -    name: the cooling device name.
> > > -    devdata: device private data.
> > > -    ops: thermal cooling devices call-backs.
> > > -	.get_max_state: get the Maximum throttle state of the
> > > cooling device.
> > > -	.get_cur_state: get the Currently requested throttle
> > > state
> > > of the cooling device.
> > > -	.set_cur_state: set the Current throttle state of the
> > > cooling device.
> > > -
> > > -1.2.2 void thermal_cooling_device_unregister(struct
> > > thermal_cooling_device *cdev)
> > > +
> > > +    name:
> > > +	the cooling device name.
> > > +    devdata:
> > > +	device private data.
> > > +    ops:
> > > +	thermal cooling devices call-backs.
> > > +
> > > +	.get_max_state:
> > > +		get the Maximum throttle state of the cooling
> > > device.
> > > +	.get_cur_state:
> > > +		get the Currently requested throttle state of
> > > the
> > > +		cooling device.
> > > +	.set_cur_state:
> > > +		set the Current throttle state of the cooling
> > > device.
> > > +
> > > +    ::
> > > +
> > > +	void thermal_cooling_device_unregister(struct
> > > thermal_cooling_device *cdev)
> > >  
> > >      This interface function removes the thermal cooling device.
> > >      It deletes the corresponding entry from /sys/class/thermal
> > > folder and
> > >      unbinds itself from all the thermal zone devices using it.
> > >  
> > >  1.3 interface for binding a thermal zone device with a thermal
> > > cooling device
> > > -1.3.1 int thermal_zone_bind_cooling_device(struct
> > > thermal_zone_device *tz,
> > > -	int trip, struct thermal_cooling_device *cdev,
> > > -	unsigned long upper, unsigned long lower, unsigned int
> > > weight);
> > > +--------------------------------------------------------------
> > > ----
> > > -----------
> > > +
> > > +    ::
> > > +
> > > +	int thermal_zone_bind_cooling_device(struct
> > > thermal_zone_device *tz,
> > > +		int trip, struct thermal_cooling_device *cdev,
> > > +		unsigned long upper, unsigned long lower,
> > > unsigned
> > > int weight);
> > >  
> > >      This interface function binds a thermal cooling device to a
> > > particular trip
> > >      point of a thermal zone device.
> > > +
> > >      This function is usually called in the thermal zone device
> > > .bind
> > > callback.
> > > -    tz: the thermal zone device
> > > -    cdev: thermal cooling device
> > > -    trip: indicates which trip point in this thermal zone the
> > > cooling device
> > > -          is associated with.
> > > -    upper:the Maximum cooling state for this trip point.
> > > -          THERMAL_NO_LIMIT means no upper limit,
> > > +
> > > +    tz:
> > > +	  the thermal zone device
> > > +    cdev:
> > > +	  thermal cooling device
> > > +    trip:
> > > +	  indicates which trip point in this thermal zone the
> > > cooling device
> > > +	  is associated with.
> > > +    upper:
> > > +	  the Maximum cooling state for this trip point.
> > > +	  THERMAL_NO_LIMIT means no upper limit,
> > >  	  and the cooling device can be in max_state.
> > > -    lower:the Minimum cooling state can be used for this trip
> > > point.
> > > -          THERMAL_NO_LIMIT means no lower limit,
> > > +    lower:
> > > +	  the Minimum cooling state can be used for this trip
> > > point.
> > > +	  THERMAL_NO_LIMIT means no lower limit,
> > >  	  and the cooling device can be in cooling state 0.
> > > -    weight: the influence of this cooling device in this thermal
> > > -            zone.  See 1.4.1 below for more information.
> > > +    weight:
> > > +	  the influence of this cooling device in this thermal
> > > +	  zone.  See 1.4.1 below for more information.
> > >  
> > > -1.3.2 int thermal_zone_unbind_cooling_device(struct
> > > thermal_zone_device *tz,
> > > -		int trip, struct thermal_cooling_device *cdev);
> > > +    ::
> > > +
> > > +	int thermal_zone_unbind_cooling_device(struct
> > > thermal_zone_device *tz,
> > > +				int trip, struct
> > > thermal_cooling_device *cdev);
> > >  
> > >      This interface function unbinds a thermal cooling device
> > > from a
> > > particular
> > >      trip point of a thermal zone device. This function is
> > > usually
> > > called in
> > >      the thermal zone device .unbind callback.
> > > -    tz: the thermal zone device
> > > -    cdev: thermal cooling device
> > > -    trip: indicates which trip point in this thermal zone the
> > > cooling device
> > > -          is associated with.
> > > +
> > > +    tz:
> > > +	the thermal zone device
> > > +    cdev:
> > > +	thermal cooling device
> > > +    trip:
> > > +	indicates which trip point in this thermal zone the
> > > cooling
> > > device
> > > +	is associated with.
> > >  
> > >  1.4 Thermal Zone Parameters
> > > -1.4.1 struct thermal_bind_params
> > > +---------------------------
> > > +
> > > +    ::
> > > +
> > > +	struct thermal_bind_params
> > > +
> > >      This structure defines the following parameters that are
> > > used to
> > > bind
> > >      a zone with a cooling device for a particular trip point.
> > > -    .cdev: The cooling device pointer
> > > -    .weight: The 'influence' of a particular cooling device on
> > > this
> > > -             zone. This is relative to the rest of the cooling
> > > -             devices. For example, if all cooling devices have a
> > > -             weight of 1, then they all contribute the same. You
> > > can
> > > -             use percentages if you want, but it's not
> > > mandatory. A
> > > -             weight of 0 means that this cooling device doesn't
> > > -             contribute to the cooling of this zone unless all
> > > cooling
> > > -             devices have a weight of 0. If all weights are 0,
> > > then
> > > -             they all contribute the same.
> > > -    .trip_mask:This is a bit mask that gives the binding
> > > relation
> > > between
> > > -               this thermal zone and cdev, for a particular trip
> > > point.
> > > -               If nth bit is set, then the cdev and thermal zone
> > > are
> > > bound
> > > -               for trip point n.
> > > -    .binding_limits: This is an array of cooling state limits.
> > > Must
> > > have
> > > -                     exactly 2 *
> > > thermal_zone.number_of_trip_points.
> > > It is an
> > > -                     array consisting of tuples <lower-state
> > > upper-  
> > > state> of  
> > > -                     state limits. Each trip will be associated
> > > with
> > > one state
> > > -                     limit tuple when binding. A NULL pointer
> > > means
> > > -                     <THERMAL_NO_LIMITS THERMAL_NO_LIMITS> on
> > > all
> > > trips.
> > > -                     These limits are used when binding a cdev
> > > to a
> > > trip point.
> > > -    .match: This call back returns success(0) if the 'tz and
> > > cdev'
> > > need to
> > > +
> > > +    .cdev:
> > > +	     The cooling device pointer
> > > +    .weight:
> > > +	     The 'influence' of a particular cooling device on
> > > this
> > > +	     zone. This is relative to the rest of the cooling
> > > +	     devices. For example, if all cooling devices have a
> > > +	     weight of 1, then they all contribute the same. You
> > > can
> > > +	     use percentages if you want, but it's not
> > > mandatory. A
> > > +	     weight of 0 means that this cooling device doesn't
> > > +	     contribute to the cooling of this zone unless all
> > > cooling
> > > +	     devices have a weight of 0. If all weights are 0,
> > > then
> > > +	     they all contribute the same.
> > > +    .trip_mask:
> > > +	       This is a bit mask that gives the binding
> > > relation
> > > between
> > > +	       this thermal zone and cdev, for a particular trip
> > > point.
> > > +	       If nth bit is set, then the cdev and thermal zone
> > > are
> > > bound
> > > +	       for trip point n.
> > > +    .binding_limits:
> > > +		     This is an array of cooling state limits.
> > > Must
> > > have
> > > +		     exactly 2 *
> > > thermal_zone.number_of_trip_points.
> > > It is an
> > > +		     array consisting of tuples <lower-state
> > > upper-  
> > > state> of  
> > > +		     state limits. Each trip will be associated
> > > with
> > > one state
> > > +		     limit tuple when binding. A NULL pointer
> > > means
> > > +		     <THERMAL_NO_LIMITS THERMAL_NO_LIMITS> on
> > > all
> > > trips.
> > > +		     These limits are used when binding a cdev
> > > to a
> > > trip point.
> > > +    .match:
> > > +	    This call back returns success(0) if the 'tz and
> > > cdev'
> > > need to
> > >  	    be bound, as per platform data.
> > > -1.4.2 struct thermal_zone_params
> > > +
> > > +    ::
> > > +
> > > +	struct thermal_zone_params
> > > +
> > >      This structure defines the platform level parameters for a
> > > thermal zone.
> > >      This data, for each thermal zone should come from the
> > > platform
> > > layer.
> > >      This is an optional feature where some platforms can choose
> > > not
> > > to
> > >      provide this data.
> > > -    .governor_name: Name of the thermal governor used for this
> > > zone
> > > -    .no_hwmon: a boolean to indicate if the thermal to hwmon
> > > sysfs
> > > interface
> > > -               is required. when no_hwmon == false, a hwmon
> > > sysfs
> > > interface
> > > -               will be created. when no_hwmon == true, nothing
> > > will
> > > be done.
> > > -               In case the thermal_zone_params is NULL, the
> > > hwmon
> > > interface
> > > -               will be created (for backward compatibility).
> > > -    .num_tbps: Number of thermal_bind_params entries for this
> > > zone
> > > -    .tbp: thermal_bind_params entries
> > > +
> > > +    .governor_name:
> > > +	       Name of the thermal governor used for this zone
> > > +    .no_hwmon:
> > > +	       a boolean to indicate if the thermal to hwmon
> > > sysfs
> > > interface
> > > +	       is required. when no_hwmon == false, a hwmon
> > > sysfs
> > > interface
> > > +	       will be created. when no_hwmon == true, nothing
> > > will
> > > be done.
> > > +	       In case the thermal_zone_params is NULL, the
> > > hwmon
> > > interface
> > > +	       will be created (for backward compatibility).
> > > +    .num_tbps:
> > > +	       Number of thermal_bind_params entries for this
> > > zone
> > > +    .tbp:
> > > +	       thermal_bind_params entries
> > >  
> > >  2. sysfs attributes structure
> > > +=============================
> > >  
> > > +==	================
> > >  RO	read only value
> > >  WO	write only value
> > >  RW	read/write value
> > > +==	================
> > >  
> > >  Thermal sysfs attributes will be represented under
> > > /sys/class/thermal.
> > >  Hwmon sysfs I/F extension is also available under
> > > /sys/class/hwmon
> > >  if hwmon is compiled in or built as a module.
> > >  
> > > -Thermal zone device sys I/F, created once it's registered:
> > > -/sys/class/thermal/thermal_zone[0-*]:
> > > +Thermal zone device sys I/F, created once it's registered::
> > > +
> > > +  /sys/class/thermal/thermal_zone[0-*]:
> > >      |---type:			Type of the thermal zone
> > >      |---temp:			Current temperature
> > >      |---mode:			Working mode of the thermal
> > > zone
> > > @@ -282,8 +396,9 @@ Thermal zone device sys I/F, created once
> > > it's
> > > registered:
> > >      |---slope:                  Slope constant applied as linear
> > > extrapolation
> > >      |---offset:                 Offset constant applied as
> > > linear
> > > extrapolation
> > >  
> > > -Thermal cooling device sys I/F, created once it's registered:
> > > -/sys/class/thermal/cooling_device[0-*]:
> > > +Thermal cooling device sys I/F, created once it's registered::
> > > +
> > > +  /sys/class/thermal/cooling_device[0-*]:
> > >      |---type:			Type of the cooling
> > > device(processor/fan/...)
> > >      |---max_state:		Maximum cooling state of the
> > > cooling device
> > >      |---cur_state:		Current cooling state of the
> > > cooling device
> > > @@ -299,11 +414,13 @@ the relationship between a thermal zone and
> > > its
> > > associated cooling device.
> > >  They are created/removed for each successful execution of
> > >  thermal_zone_bind_cooling_device/thermal_zone_unbind_cooling_dev
> > > ice.
> > >  
> > > -/sys/class/thermal/thermal_zone[0-*]:
> > > +::
> > > +
> > > +  /sys/class/thermal/thermal_zone[0-*]:
> > >      |---cdev[0-*]:		[0-*]th cooling device in
> > > current
> > > thermal zone
> > >      |---cdev[0-*]_trip_point:	Trip point that cdev[0-*]
> > > is
> > > associated with
> > >      |---cdev[0-*]_weight:       Influence of the cooling device
> > > in
> > > -                                this thermal zone
> > > +				this thermal zone
> > >  
> > >  Besides the thermal zone device sysfs I/F and cooling device
> > > sysfs
> > > I/F,
> > >  the generic thermal driver also creates a hwmon sysfs I/F for
> > > each
> > > _type_
> > > @@ -311,16 +428,17 @@ of thermal zone device. E.g. the generic
> > > thermal driver registers one hwmon
> > >  class device and build the associated hwmon sysfs I/F for all
> > > the
> > > registered
> > >  ACPI thermal zones.
> > >  
> > > -/sys/class/hwmon/hwmon[0-*]:
> > > +::
> > > +
> > > +  /sys/class/hwmon/hwmon[0-*]:
> > >      |---name:			The type of the thermal
> > > zone
> > > devices
> > >      |---temp[1-*]_input:	The current temperature of
> > > thermal
> > > zone [1-*]
> > >      |---temp[1-*]_critical:	The critical trip point of
> > > thermal zone [1-*]
> > >  
> > >  Please read Documentation/hwmon/sysfs-interface.rst for
> > > additional
> > > information.
> > >  
> > > -***************************
> > > -* Thermal zone attributes *
> > > -***************************
> > > +Thermal zone attributes
> > > +-----------------------
> > >  
> > >  type
> > >  	Strings which represent the thermal zone type.
> > > @@ -340,54 +458,67 @@ mode
> > >  	This file gives information about the algorithm that is
> > > currently
> > >  	managing the thermal zone. It can be either default
> > > kernel
> > > based
> > >  	algorithm or user space application.
> > > -	enabled		= enable Kernel Thermal
> > > management.
> > > -	disabled	= Preventing kernel thermal zone driver
> > > actions upon
> > > +
> > > +	enabled
> > > +			  enable Kernel Thermal management.
> > > +	disabled
> > > +			  Preventing kernel thermal zone driver
> > > actions upon
> > >  			  trip points so that user application
> > > can
> > > take full
> > >  			  charge of the thermal management.
> > > +
> > >  	RW, Optional
> > >  
> > >  policy
> > >  	One of the various thermal governors used for a
> > > particular
> > > zone.
> > > +
> > >  	RW, Required
> > >  
> > >  available_policies
> > >  	Available thermal governors which can be used for a
> > > particular zone.
> > > +
> > >  	RO, Required
> > >  
> > > -trip_point_[0-*]_temp
> > > +`trip_point_[0-*]_temp`
> > >  	The temperature above which trip point will be fired.
> > > +
> > >  	Unit: millidegree Celsius
> > > +
> > >  	RO, Optional
> > >  
> > > -trip_point_[0-*]_type
> > > +`trip_point_[0-*]_type`
> > >  	Strings which indicate the type of the trip point.
> > > -	E.g. it can be one of critical, hot, passive, active[0-
> > > *]
> > > for ACPI
> > > +
> > > +	E.g. it can be one of critical, hot, passive, `active[0-
> > > *]`
> > > for ACPI
> > >  	thermal zone.
> > > +
> > >  	RO, Optional
> > >  
> > > -trip_point_[0-*]_hyst
> > > +`trip_point_[0-*]_hyst`
> > >  	The hysteresis value for a trip point, represented as an
> > > integer
> > >  	Unit: Celsius
> > >  	RW, Optional
> > >  
> > > -cdev[0-*]
> > > +`cdev[0-*]`
> > >  	Sysfs link to the thermal cooling device node where the
> > > sys
> > > I/F
> > >  	for cooling device throttling control represents.
> > > +
> > >  	RO, Optional
> > >  
> > > -cdev[0-*]_trip_point
> > > -	The trip point in this thermal zone which cdev[0-*] is
> > > associated
> > > +`cdev[0-*]_trip_point`
> > > +	The trip point in this thermal zone which `cdev[0-*]` is
> > > associated
> > >  	with; -1 means the cooling device is not associated with
> > > any
> > > trip
> > >  	point.
> > > +
> > >  	RO, Optional
> > >  
> > > -cdev[0-*]_weight
> > > -        The influence of cdev[0-*] in this thermal zone. This
> > > value
> > > -        is relative to the rest of cooling devices in the
> > > thermal
> > > -        zone. For example, if a cooling device has a weight
> > > double
> > > -        than that of other, it's twice as effective in cooling
> > > the
> > > -        thermal zone.
> > > -        RW, Optional
> > > +`cdev[0-*]_weight`
> > > +	The influence of `cdev[0-*]` in this thermal zone. This
> > > value
> > > +	is relative to the rest of cooling devices in the
> > > thermal
> > > +	zone. For example, if a cooling device has a weight
> > > double
> > > +	than that of other, it's twice as effective in cooling
> > > the
> > > +	thermal zone.
> > > +
> > > +	RW, Optional
> > >  
> > >  passive
> > >  	Attribute is only present for zones in which the passive
> > > cooling
> > > @@ -395,8 +526,11 @@ passive
> > >  	and can be set to a temperature (in millidegrees) to
> > > enable
> > > a
> > >  	passive trip point for the zone. Activation is done by
> > > polling with
> > >  	an interval of 1 second.
> > > +
> > >  	Unit: millidegrees Celsius
> > > +
> > >  	Valid values: 0 (disabled) or greater than 1000
> > > +
> > >  	RW, Optional
> > >  
> > >  emul_temp
> > > @@ -407,17 +541,21 @@ emul_temp
> > >  	threshold and its associated cooling action. This is
> > > write
> > > only node
> > >  	and writing 0 on this node should disable emulation.
> > >  	Unit: millidegree Celsius
> > > +
> > >  	WO, Optional
> > >  
> > > -	  WARNING: Be careful while enabling this option on
> > > production systems,
> > > -	  because userland can easily disable the thermal policy
> > > by
> > > simply
> > > -	  flooding this sysfs node with low temperature values.
> > > +	  WARNING:
> > > +	    Be careful while enabling this option on production
> > > systems,
> > > +	    because userland can easily disable the thermal
> > > policy
> > > by simply
> > > +	    flooding this sysfs node with low temperature
> > > values.
> > >  
> > >  sustainable_power
> > >  	An estimate of the sustained power that can be
> > > dissipated by
> > >  	the thermal zone. Used by the power allocator governor.
> > > For
> > > -	more information see
> > > Documentation/thermal/power_allocator.txt
> > > +	more information see
> > > Documentation/thermal/power_allocator.rst
> > > +
> > >  	Unit: milliwatts
> > > +
> > >  	RW, Optional
> > >  
> > >  k_po
> > > @@ -425,7 +563,8 @@ k_po
> > >  	controller during temperature overshoot. Temperature
> > > overshoot
> > >  	is when the current temperature is above the "desired
> > >  	temperature" trip point. For more information see
> > > -	Documentation/thermal/power_allocator.txt
> > > +	Documentation/thermal/power_allocator.rst
> > > +
> > >  	RW, Optional
> > >  
> > >  k_pu
> > > @@ -433,20 +572,23 @@ k_pu
> > >  	controller during temperature undershoot. Temperature
> > > undershoot
> > >  	is when the current temperature is below the "desired
> > >  	temperature" trip point. For more information see
> > > -	Documentation/thermal/power_allocator.txt
> > > +	Documentation/thermal/power_allocator.rst
> > > +
> > >  	RW, Optional
> > >  
> > >  k_i
> > >  	The integral term of the power allocator governor's PID
> > >  	controller. This term allows the PID controller to
> > > compensate
> > >  	for long term drift. For more information see
> > > -	Documentation/thermal/power_allocator.txt
> > > +	Documentation/thermal/power_allocator.rst
> > > +
> > >  	RW, Optional
> > >  
> > >  k_d
> > >  	The derivative term of the power allocator governor's
> > > PID
> > >  	controller. For more information see
> > > -	Documentation/thermal/power_allocator.txt
> > > +	Documentation/thermal/power_allocator.rst
> > > +
> > >  	RW, Optional
> > >  
> > >  integral_cutoff
> > > @@ -456,8 +598,10 @@ integral_cutoff
> > >  	example, if integral_cutoff is 0, then the integral term
> > > only
> > >  	accumulates error when temperature is above the desired
> > >  	temperature trip point. For more information see
> > > -	Documentation/thermal/power_allocator.txt
> > > +	Documentation/thermal/power_allocator.rst
> > > +
> > >  	Unit: millidegree Celsius
> > > +
> > >  	RW, Optional
> > >  
> > >  slope
> > > @@ -465,6 +609,7 @@ slope
> > >  	to determine a hotspot temperature based off the
> > > sensor's
> > >  	raw readings. It is up to the device driver to determine
> > >  	the usage of these values.
> > > +
> > >  	RW, Optional
> > >  
> > >  offset
> > > @@ -472,28 +617,33 @@ offset
> > >  	to determine a hotspot temperature based off the
> > > sensor's
> > >  	raw readings. It is up to the device driver to determine
> > >  	the usage of these values.
> > > +
> > >  	RW, Optional
> > >  
> > > -*****************************
> > > -* Cooling device attributes *
> > > -*****************************
> > > +Cooling device attributes
> > > +-------------------------
> > >  
> > >  type
> > >  	String which represents the type of device, e.g:
> > > +
> > >  	- for generic ACPI: should be "Fan", "Processor" or
> > > "LCD"
> > >  	- for memory controller device on intel_menlow platform:
> > >  	  should be "Memory controller".
> > > +
> > >  	RO, Required
> > >  
> > >  max_state
> > >  	The maximum permissible cooling state of this cooling
> > > device.
> > > +
> > >  	RO, Required
> > >  
> > >  cur_state
> > >  	The current cooling state of this cooling device.
> > >  	The value can any integer numbers between 0 and
> > > max_state:
> > > +
> > >  	- cur_state == 0 means no cooling
> > >  	- cur_state == max_state means the maximum cooling.
> > > +
> > >  	RW, Required
> > >  
> > >  stats/reset
> > > @@ -508,9 +658,11 @@ stats/time_in_state_ms:
> > >  	units here is 10mS (similar to other time exported in
> > > /proc).
> > >  	RO, Required
> > >  
> > > +
> > >  stats/total_trans:
> > >  	A single positive value showing the total number of
> > > times
> > > the state of a
> > >  	cooling device is changed.
> > > +
> > >  	RO, Required
> > >  
> > >  stats/trans_table:
> > > @@ -522,6 +674,7 @@ stats/trans_table:
> > >  	RO, Required
> > >  
> > >  3. A simple implementation
> > > +==========================
> > >  
> > >  ACPI thermal zone may support multiple trip points like
> > > critical,
> > > hot,
> > >  passive, active. If an ACPI thermal zone supports critical,
> > > passive,
> > > @@ -532,11 +685,10 @@ thermal_cooling_device. Both are considered
> > > to
> > > have the same
> > >  effectiveness in cooling the thermal zone.
> > >  
> > >  If the processor is listed in _PSL method, and the fan is listed
> > > in
> > > _AL0
> > > -method, the sys I/F structure will be built like this:
> > > +method, the sys I/F structure will be built like this::
> > >  
> > > -/sys/class/thermal:
> > > -
> > > -|thermal_zone1:
> > > + /sys/class/thermal:
> > > +  |thermal_zone1:
> > >      |---type:			acpitz
> > >      |---temp:			37000
> > >      |---mode:			enabled
> > > @@ -557,24 +709,24 @@ method, the sys I/F structure will be built
> > > like this:
> > >      |---cdev1_trip_point:	2	/* cdev1 can be used
> > > for
> > > active[0]*/
> > >      |---cdev1_weight:           1024
> > >  
> > > -|cooling_device0:
> > > +  |cooling_device0:
> > >      |---type:			Processor
> > >      |---max_state:		8
> > >      |---cur_state:		0
> > >  
> > > -|cooling_device3:
> > > +  |cooling_device3:
> > >      |---type:			Fan
> > >      |---max_state:		2
> > >      |---cur_state:		0
> > >  
> > > -/sys/class/hwmon:
> > > -
> > > -|hwmon0:
> > > + /sys/class/hwmon:
> > > +  |hwmon0:
> > >      |---name:			acpitz
> > >      |---temp1_input:		37000
> > >      |---temp1_crit:		100000
> > >  
> > >  4. Event Notification
> > > +=====================
> > >  
> > >  The framework includes a simple notification mechanism, in the
> > > form
> > > of a
> > >  netlink event. Netlink socket initialization is done during the
> > > _init_
> > > @@ -587,21 +739,28 @@ event will be one of:{THERMAL_AUX0,
> > > THERMAL_AUX1, THERMAL_CRITICAL,
> > >  THERMAL_DEV_FAULT}. Notification can be sent when the current
> > > temperature
> > >  crosses any of the configured thresholds.
> > >  
> > > -5. Export Symbol APIs:
> > > +5. Export Symbol APIs
> > > +=====================
> > > +
> > > +5.1. get_tz_trend
> > > +-----------------
> > >  
> > > -5.1: get_tz_trend:
> > >  This function returns the trend of a thermal zone, i.e the rate
> > > of
> > > change
> > >  of temperature of the thermal zone. Ideally, the thermal sensor
> > > drivers
> > >  are supposed to implement the callback. If they don't, the
> > > thermal
> > >  framework calculated the trend by comparing the previous and the
> > > current
> > >  temperature values.
> > >  
> > > -5.2:get_thermal_instance:
> > > +5.2. get_thermal_instance
> > > +-------------------------
> > > +
> > >  This function returns the thermal_instance corresponding to a
> > > given
> > >  {thermal_zone, cooling_device, trip_point} combination. Returns
> > > NULL
> > >  if such an instance does not exist.
> > >  
> > > -5.3:thermal_notify_framework:
> > > +5.3. thermal_notify_framework
> > > +-----------------------------
> > > +
> > >  This function handles the trip events from sensor drivers. It
> > > starts
> > >  throttling the cooling devices according to the policy
> > > configured.
> > >  For CRITICAL and HOT trip points, this notifies the respective
> > > drivers,
> > > @@ -609,12 +768,15 @@ and does actual throttling for other trip
> > > points i.e ACTIVE and PASSIVE.
> > >  The throttling policy is based on the configured platform data;
> > > if
> > > no
> > >  platform data is provided, this uses the step_wise throttling
> > > policy.
> > >  
> > > -5.4:thermal_cdev_update:
> > > +5.4. thermal_cdev_update
> > > +------------------------
> > > +
> > >  This function serves as an arbitrator to set the state of a
> > > cooling
> > >  device. It sets the cooling device to the deepest cooling state
> > > if
> > >  possible.
> > >  
> > > -6. thermal_emergency_poweroff:
> > > +6. thermal_emergency_poweroff
> > > +=============================
> > >  
> > >  On an event of critical trip temperature crossing. Thermal
> > > framework
> > >  allows the system to shutdown gracefully by calling
> > > orderly_poweroff().
> > > diff --git a/Documentation/thermal/x86_pkg_temperature_thermal
> > > b/Documentation/thermal/x86_pkg_temperature_thermal.rst
> > > similarity index 80%
> > > rename from Documentation/thermal/x86_pkg_temperature_thermal
> > > rename to Documentation/thermal/x86_pkg_temperature_thermal.rst
> > > index 17a3a4c0a0ca..f134dbd3f5a9 100644
> > > --- a/Documentation/thermal/x86_pkg_temperature_thermal
> > > +++ b/Documentation/thermal/x86_pkg_temperature_thermal.rst
> > > @@ -1,19 +1,23 @@
> > > +===================================
> > >  Kernel driver: x86_pkg_temp_thermal
> > > -===================
> > > +===================================
> > >  
> > >  Supported chips:
> > > +
> > >  * x86: with package level thermal management
> > > +
> > >  (Verify using: CPUID.06H:EAX[bit 6] =1)
> > >  
> > >  Authors: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.co
> > > m>
> > >  
> > >  Reference
> > > ----
> > > +---------
> > > +
> > >  Intel® 64 and IA-32 Architectures Software Developer’s Manual
> > > (Jan,
> > > 2013):
> > >  Chapter 14.6: PACKAGE LEVEL THERMAL MANAGEMENT
> > >  
> > >  Description
> > > ----------
> > > +-----------
> > >  
> > >  This driver register CPU digital temperature package level
> > > sensor as
> > > a thermal
> > >  zone with maximum two user mode configurable trip points. Number
> > > of
> > > trip points
> > > @@ -25,23 +29,27 @@ take any action to control temperature.
> > >  Threshold management
> > >  --------------------
> > >  Each package will register as a thermal zone under
> > > /sys/class/thermal.
> > > -Example:
> > > -/sys/class/thermal/thermal_zone1
> > > +
> > > +Example::
> > > +
> > > +	/sys/class/thermal/thermal_zone1
> > >  
> > >  This contains two trip points:
> > > +
> > >  - trip_point_0_temp
> > >  - trip_point_1_temp
> > >  
> > >  User can set any temperature between 0 to TJ-Max temperature.
> > > Temperature units
> > > -are in milli-degree Celsius. Refer to
> > > "Documentation/thermal/sysfs-
> > > api.txt" for
> > > +are in milli-degree Celsius. Refer to
> > > "Documentation/thermal/sysfs-
> > > api.rst" for
> > >  thermal sys-fs details.
> > >  
> > >  Any value other than 0 in these trip points, can trigger thermal
> > > notifications.
> > >  Setting 0, stops sending thermal notifications.
> > >  
> > > -Thermal notifications: To get kobject-uevent notifications, set
> > > the
> > > thermal zone
> > > -policy to "user_space". For example: echo -n "user_space" >
> > > policy
> > > -
> > > -
> > > +Thermal notifications:
> > > +To get kobject-uevent notifications, set the thermal zone
> > > +policy to "user_space".
> > >  
> > > +For example::
> > >  
> > > +	echo -n "user_space" > policy
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index d9e214f68e52..b2254bc8e495 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -15687,7 +15687,7 @@ M:	Viresh Kumar <viresh.kumar@lina
> > > ro.o  
> > > rg>  
> > >  M:	Javi Merino <javi.merino@kernel.org>
> > >  L:	linux-pm@vger.kernel.org
> > >  S:	Supported
> > > -F:	Documentation/thermal/cpu-cooling-api.txt
> > > +F:	Documentation/thermal/cpu-cooling-api.rst
> > >  F:	drivers/thermal/cpu_cooling.c
> > >  F:	include/linux/cpu_cooling.h
> > >  
> > > diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> > > index 15a4ca5d7099..681047f8cc05 100644
> > > --- a/include/linux/thermal.h
> > > +++ b/include/linux/thermal.h
> > > @@ -251,7 +251,7 @@ struct thermal_bind_params {
> > >  	 * platform characterization. This value is relative to
> > > the
> > >  	 * rest of the weights so a cooling device whose weight
> > > is
> > >  	 * double that of another cooling device is twice as
> > > -	 * effective. See Documentation/thermal/sysfs-api.txt
> > > for
> > > more
> > > +	 * effective. See Documentation/thermal/sysfs-api.rst
> > > for
> > > more
> > >  	 * information.
> > >  	 */
> > >  	int weight;
> > > @@ -259,7 +259,7 @@ struct thermal_bind_params {
> > >  	/*
> > >  	 * This is a bit mask that gives the binding relation
> > > between this
> > >  	 * thermal zone and cdev, for a particular trip point.
> > > -	 * See Documentation/thermal/sysfs-api.txt for more
> > > information.
> > > +	 * See Documentation/thermal/sysfs-api.rst for more
> > > information.
> > >  	 */
> > >  	int trip_mask;
> > >    
> 
> 
> Thanks,
> Mauro
